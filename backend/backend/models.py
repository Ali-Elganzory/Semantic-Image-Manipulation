from dataclasses import dataclass

from sqlalchemy import Column, Integer, String

from backend.database import Base


@dataclass
class Label(Base):
    __tablename__ = 'labels'
    id: int = Column(Integer, primary_key=True)
    index: int = Column(Integer, nullable=False)
    name: str = Column(String(50), nullable=False)

    def __repr__(self):
        return f'<Label {self.name} ({self.index})>'
