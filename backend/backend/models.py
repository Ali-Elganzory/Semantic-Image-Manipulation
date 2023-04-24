from dataclasses import dataclass
from enum import Enum
from typing import Self, Union

from sqlalchemy import (
    Column, Double, ForeignKey, Integer, String, Enum as DBEnum
)

from backend.database import db_session, Base


############################################
# CRUD Mixin (helper methods)
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


############################################
# Models
############################################

@dataclass
class User(Base, CrudMixin):
    __tablename__ = 'users'
    id: int = Column(Integer, primary_key=True)
    uuid: str = Column(String(50), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'


@dataclass
class Label(Base, CrudMixin):
    __tablename__ = 'labels'
    id: int = Column(Integer, primary_key=True)
    name: str = Column(String(50), nullable=False)

    def __repr__(self):
        return f'<Label {self.name} ({self.index})>'


@dataclass
class Image(Base, CrudMixin):
    __tablename__ = 'images'
    id: int = Column(Integer, primary_key=True)
    user_id: int = Column(ForeignKey(User.id))
    name: str = Column(String(50), nullable=False)
    path: str = Column(String(100), nullable=False)
    inpainted_path: str = Column(String(100))

    def __repr__(self):
        return f'<Image {self.name} ({self.path})>'


@dataclass
class Detection(Base, CrudMixin):
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

    def __repr__(self):
        return f'<Detection {self.id}>'


class TaskType(Enum):
    DETECTION = 'detection'
    CLASSIFICATION = 'classification'


class TaskStatus(Enum):
    PENDING = 'pending'
    RUNNING = 'running'
    SUCCESS = 'success'
    ERROR = 'error'


@dataclass
class Task(Base, CrudMixin):
    __tablename__ = 'tasks'
    id: int = Column(Integer, primary_key=True)
    image_id: int = Column(ForeignKey(Image.id), nullable=False)
    type: TaskType = Column(DBEnum(TaskType), nullable=False)
    status: TaskStatus = Column(DBEnum(TaskStatus), nullable=False)
    progress: int = Column(Integer, nullable=False, default=0)

    def __repr__(self):
        return f'<Task {self.id}>'
