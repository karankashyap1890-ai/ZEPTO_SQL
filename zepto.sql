CREATE TABLE zepto(
	sku_id SERIAL PRIMARY KEY,
	category VARCHAR(120),
	name VARCHAR(150) NOT NULL,
	mrp NUMERIC(8,2),
	discountpercent NUMERIC(5,2),
	availableQuentity INTEGER,
	discountedsellingprice NUMERIC(8,2),
	weightInGms INTEGER,
	outofStock BOOLEAN,
	Quantity INTEGER	
);

SELECT * FROM ZEPTO;

-- Q1 FIND NULL VALUE. 
	SELECT * FROM zepto
	WHERE name IS NULL
	OR 
	mrp IS NULL;

--Different product category 
	SELECT DISTINCT category
	FROM zepto 
	ORDER BY  category;

--Peoduct in stock vs out of stock 
	SELECT outofStock, COUNT(sku_id)
	FROM ZEPTO 
	GROUP BY outofStock;


--Produut name present multiple times 
	SELECT  name , COUNT (sku_id)  AS number_of_sku
	FROM zepto 
	GROUP BY name 
	HAVING COUNT(sku_id) > 1
	ORDER BY COUNT (sku_id) DESC;


--data cleaning 

-- product with price = 0
	SELECT * FROM zepto 
	WHERE mrp = 0 OR discountedsellingprice =0;

-- convert paise to rupee
	UPDATE zepto 
	SET mrp = mrp / 100.0,
	discountedsellingprice =  discountedsellingprice / 100.0;


--Q! Find the top 10 best value products based on discount percentage.
	SELECT DISTINCT name, mrp, discountpercent
	FROM zepto
	ORDER BY discountpercent DESC
	LIMIT 10;


--Q2 What are the products with high MRP but are out of stock?
	SELECT sku_id, name, category, mrp
	FROM ZEPTO
	WHERE outofStock = TRUE
	ORDER BY mrp DESC;
             
			 --OR 
			 
	SELECT DISTINCT name, mrp 
	FROM zepto
	WHERE outofStock = true AND mrp > 300
	ORDER BY mrp DESC;
	


--Q3 Calculate estimated revenue for each category.
	SELECT category,
    SUM (discountedsellingprice * availableQuentity) AS estimated_revenue
	FROM zepto
	GROUP BY category
	ORDER BY estimated_revenue DESC;


--Q4 Find all products where the MRP is greater than 500 rupees and the discount is less than 10%.
	SELECT sku_id, name, mrp, discountpercent
	FROM zepto
	WHERE mrp > 500 AND discountpercent < 10

	            --OR
				
	SELECT  DISTINCT name, mrp, discountpercent
	FROM zepto
	WHERE mrp > 500 AND discountpercent < 10
	ORDER BY mrp DESC , discountpercent DESC;


--Q5 Identify the top 5 categories offering the highest average discount percentage.
	SELECT category,
    AVG(discountpercent) AS avg_discount
	FROM zepto
	GROUP BY category
	ORDER BY avg_discount DESC
	LIMIT 5;


--Q6 Group the products into categories like low, medium, and bulk.
	SELECT sku_id, name, category, weightInGms,
       CASE
           WHEN weightInGms < 100 THEN 'Low'
           WHEN weightInGms BETWEEN 100 AND 500 THEN 'Medium'
           ELSE 'Bulk'
    	END AS weight_category
	FROM zepto;


--Q7 What is the total inventory weight per category?
	SELECT category,
    SUM (weightInGms * availableQuentity) AS total_inventory_weight
	FROM zepto
	GROUP BY category
	ORDER BY total_inventory_weight DESC; 
	
	
	
	














