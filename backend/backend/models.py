from dataclasses import asdict, dataclass
from datetime import datetime
from enum import Enum
from typing import List, Self, Union

from sqlalchemy import (
    Column, Double, ForeignKey, Integer, String, Enum as DBEnum, func, DateTime
)
from sqlalchemy.orm import relationship

from backend.database import db_session, Base


############################################
# Mixins (Helper Classes)
############################################

from backend.database import db_session


class CrudMixin:
    def get(self, id: int) -> Union[Self, None]:
        return db_session.query(self.__class__).get(id)

    def save(self) -> Self:
        db_session.add(self)
        db_session.commit()
        return self

    def update(self) -> Self:
        db_session.commit()
        return self

    def delete(self) -> None:
        db_session.delete(self)
        db_session.commit()

    def asdict(self) -> dict:
        return asdict(self)


@dataclass
class DatesMixin:
    created_at: datetime = Column(DateTime, default=datetime.utcnow)
    updated_at: datetime = Column(
        DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

############################################
# Models
############################################


@dataclass
class User(Base, CrudMixin, DatesMixin):
    __tablename__ = 'users'
    id: int = Column(Integer, primary_key=True)
    uuid: str = Column(String(50), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'


@dataclass
class Label(Base, CrudMixin, DatesMixin):
    __tablename__ = 'labels'
    id: int = Column(Integer, primary_key=True)
    name: str = Column(String(50), nullable=False)

    def __repr__(self):
        return f'<Label {self.name} ({self.index})>'


@dataclass
class Image(Base, CrudMixin, DatesMixin):
    __tablename__ = 'images'
    id: int = Column(Integer, primary_key=True)
    user_id: int = Column(ForeignKey(User.id))
    name: str = Column(String(50), nullable=False)
    path: str = Column(String(100), nullable=False)
    width: int = Column(Integer, nullable=False)
    height: int = Column(Integer, nullable=False)
    inpainted_path: str = Column(String(100))

    def __repr__(self):
        return f'<Image {self.name} ({self.path})>'


@dataclass
class Detection(Base, CrudMixin, DatesMixin):
    __tablename__ = 'detections'
    id: int = Column(Integer, primary_key=True)
    image_id: int = Column(ForeignKey(Image.id), nullable=False)
    label_id: int = Column(ForeignKey(Label.id), nullable=False)
    task_id: int = Column(ForeignKey('tasks.id'), nullable=False)
    confidence: float = Column(Double, nullable=False)
    x: int = Column(Integer, nullable=False)
    y: int = Column(Integer, nullable=False)
    w: int = Column(Integer, nullable=False)
    h: int = Column(Integer, nullable=False)

    label: Label = relationship(Label, lazy='joined')

    def __repr__(self):
        return f'<Detection {self.id}>'


class TaskType(str, Enum):
    DETECTION = 'detection'
    CLASSIFICATION = 'classification'


class TaskStatus(str, Enum):
    PENDING = 'pending'
    RUNNING = 'running'
    SUCCESS = 'success'
    ERROR = 'error'


@dataclass
class Task(Base, CrudMixin, DatesMixin):
    __tablename__ = 'tasks'
    id: int = Column(Integer, primary_key=True)
    image_id: int = Column(ForeignKey(Image.id), nullable=False)
    type: TaskType = Column(DBEnum(TaskType), nullable=False)
    status: TaskStatus = Column(DBEnum(TaskStatus), nullable=False)
    progress: int = Column(Integer, nullable=False, default=0)

    def __repr__(self):
        return f'<Task {self.id}>'

    def of_image(image_id: int) -> List['Task']:
        subquery = db_session\
            .query(
                Task.id,
                func.rank().over(
                    order_by=Task.created_at.desc(),
                    partition_by=Task.type,
                ),
            )\
            .filter(Task.image_id == image_id)\
            .all()

        task_ids = [task_id for task_id, rank in subquery if rank == 1]

        tasks = db_session\
            .query(Task)\
            .filter(Task.id.in_(task_ids))\
            .all()

        return tasks
