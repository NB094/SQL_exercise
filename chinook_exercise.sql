/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. 
 The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. 
 Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
SELECT artists.Name FROM artists
  LEFT JOIN albums ON artists.ArtistId = albums.ArtistId
  WHERE artists.ArtistId NOT IN (SELECT ArtistId from albums);

/* or WHERE albums.ArtistId ISNULL

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
/*SELECT * from genres;*/

SELECT DISTINCT artists.name FROM artists
  JOIN albums ON artists.ArtistId = albums.ArtistId
  JOIN tracks ON albums.AlbumId = tracks.AlbumId
  JOIN genres ON genres.GenreId = tracks.GenreId
  WHERE genres.Name = "Latin";

/* TASK III
Which video track has the longest length?
*/
SELECT name FROM tracks
  WHERE Milliseconds = (SELECT MAX(Milliseconds) FROM tracks);

/* TASK IV
Find the names of customers who live in the same city as the top employee 
(The one not managed by anyone).
*/

SELECT * FROM employees;
SELECT * FROM customers;

SELECT customers.FirstName, customers.LastName FROM customers
  JOIN employees
  ON customers.SupportRepId = employees.EmployeeId
  WHERE customers.City = (SELECT employees.City FROM employees WHERE employees.ReportsTo ISNULL);
  

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT DISTINCT managers.FirstName, managers.LastName from employees
  JOIN employees managers
  ON employees.ReportsTo = managers.EmployeeId
  JOIN customers
  ON employees.EmployeeId = customers.SupportRepId
  WHERE customers.country = "Brazil";

/* TASK VI
Which playlists have no Latin tracks?
*/
SELECT * FROM playlists;

SELECT DISTINCT playlists.Name FROM playlists
  LEFT JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
  LEFT JOIN tracks ON playlist_track.TrackId = tracks.TrackId
  LEFT JOIN genres ON genres.GenreId = tracks.GenreId
  WHERE genres.Name != "Latin";