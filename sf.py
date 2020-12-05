from stockfish import Stockfish

stockfish = Stockfish("/usr/local/Cellar/stockfish/12/bin/stockfish")
stockfish = Stockfish(parameters={"Threads": 2, "Minimum Thinking Time": 1})

def moveRecommendation(UCIMoveArr, moveTime):
  stockfish.set_position(UCIMoveArr)
  move = stockfish.get_best_move_time(moveTime)
  return move

def setInitialPosition(FEN):
  stockfish.set_fen_position(FEN)

def getFEN():
  return stockfish.get_fen_position()