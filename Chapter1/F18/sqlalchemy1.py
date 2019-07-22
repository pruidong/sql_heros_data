from sqlalchemy import Column, String, Integer, Float,create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
Base = declarative_base()
# 初始化数据库连接，修改为你的数据库用户名和密码
engine = create_engine('mysql+mysqlconnector://root:123456@localhost:3306/geektime-sql')

# 定义 Player 对象:
class Player(Base):
    # 表的名字:
    __tablename__ = 'player'
 
    # 表的结构:
    player_id = Column(Integer, primary_key=True, autoincrement=True)
    team_id = Column(Integer)
    player_name = Column(String(255))
    height = Column(Float(3,2))


# 增加 to_dict() 方法到 Base 类中
def to_dict(self):
    return {c.name: getattr(self, c.name, None)
            for c in self.__table__.columns}



if __name__ == '__main__':
	# 创建 DBSession 类型:
	DBSession = sessionmaker(bind=engine)
	# 创建 session 对象:
	session = DBSession()

	# 创建 Player 对象:
	new_player = Player(team_id = 1003, player_name = "约翰 - 科林斯", height = 2.08)
	# 添加到 session:
	session.add(new_player)
	# 提交即保存到数据库:
	session.commit()
	# 关闭 session:
	session.close()
	# 将对象可以转化为 dict 类型
	Base.to_dict = to_dict
	# 查询身高 >=2.08 的球员有哪些
	# rows = session.query(Player).filter(Player.height >=2.08, Player.height <=2.10).all()
	# from sqlalchemy import or_
	# rows = session.query(Player).filter(or_(Player.height >=2.08, Player.height <=2.10)).all()
	rows = session.query(Player).filter(Player.height >= 2.08).all()
	print([row.to_dict() for row in rows])
	from sqlalchemy import func
	rows = session.query(Player.team_id, func.count(Player.player_id)).group_by(Player.team_id).having(func.count(Player.player_id)>5).order_by(func.count(Player.player_id).asc()).all()
	print(rows)
	row = session.query(Player).filter(Player.player_name=='约翰 - 科林斯').first()
	session.delete(row)
	session.commit()
	session.close()
	row = session.query(Player).filter(Player.player_name=='索恩-马克').first()
	row.height = 2.17
	session.commit()
	session.close()


