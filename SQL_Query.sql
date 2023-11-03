-- Create the Players table
CREATE TABLE Players (
    PlayerID INTEGER PRIMARY KEY,
    Name TEXT,
    Wins INTEGER,
    Losses INTEGER,
    Draws INTEGER
);

-- Create the Games table
CREATE TABLE Games (
    GameID INTEGER PRIMARY KEY,
    StartDate TEXT,
    EndDate TEXT,
    Result TEXT,
    FOREIGN KEY (GameID) REFERENCES Players(PlayerID)
);

-- Create the Chessboards table
CREATE TABLE Chessboards (
    BoardID INTEGER PRIMARY KEY,
    CurrentFEN TEXT,
    MoveHistory TEXT
);

-- Create the Pieces table
CREATE TABLE Pieces (
    PieceID INTEGER PRIMARY KEY,
    Type TEXT,
    Color TEXT,
    PositionX INTEGER,
    PositionY INTEGER,
    BoardID INTEGER,
    FOREIGN KEY (BoardID) REFERENCES Chessboards(BoardID)
);

-- Create a table to represent the relationship between Players and Games (Many-to-Many)
CREATE TABLE PlayerGames (
    PlayerID INTEGER,
    GameID INTEGER,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

-- Create a table to represent the relationship between Players and Pieces (Many-to-Many)
CREATE TABLE PlayerPieces (
    PlayerID INTEGER,
    PieceID INTEGER,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (PieceID) REFERENCES Pieces(PieceID)
);

-- Insert sample data
INSERT INTO Players (PlayerID,Name, Wins, Losses, Draws)
VALUES (1,'Player 1', 10, 5, 3),
       (2,'Player 2', 8, 6, 2);

INSERT INTO Games (GameID,StartDate, EndDate, Result)
VALUES (1,'2023-01-01', '2023-01-10', 'Draw'),
       (2,'2023-02-01', '2023-02-15', 'Win');

-- Query to retrieve player details and their game results
SELECT Players.Name, Games.Result
FROM Players
JOIN PlayerGames ON Players.PlayerID = PlayerGames.PlayerID
JOIN Games ON PlayerGames.GameID = Games.GameID;

-- Query to retrieve pieces for a specific chessboard
SELECT Pieces.Type, Pieces.Color, Pieces.PositionX, Pieces.PositionY
FROM Chessboards
JOIN Pieces ON Chessboards.BoardID = Pieces.BoardID
WHERE Chessboards.BoardID = 1;

ALTER TABLE players
ADD total_games INT

UPDATE players
SET total_games = Wins + Losses + Draws
WHERE PlayerID = 1;

UPDATE players
SET total_games = Wins + Losses + Draws
WHERE PlayerID = 2;
