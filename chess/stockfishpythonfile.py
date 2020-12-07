from stockfish import Stockfish

stockfish = Stockfish("/usr/local/Cellar/stockfish/12")
stockfish = Stockfish(parameters={"Threads": 2, "Minimum Thinking Time": 5})

 def setInitialPosition(FEN):
   stockfish.set_fen_position(FEN)

 def getFEN():
   return stockfish.get_fen_position()

def moveRecommendation(UCIMoveArr, moveTime):
  stockfish.set_position(UCIMoveArr)
  return stockfish.get_best_move_time(moveTime)
