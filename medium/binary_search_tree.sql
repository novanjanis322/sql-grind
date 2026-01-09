-- Link: https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true

SELECT
      N,
      CASE
          WHEN P IS NULL THEN 'Root'
          WHEN N IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Inner'
          ELSE 'Leaf'
      END AS node_type
  FROM BST
  ORDER BY N;
