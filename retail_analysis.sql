-- Calculate correlation coefficients for the specified pairs
WITH correlations AS (
    -- Returns vs Promo_Spend
    SELECT 
        'Returns-Promo_Spend' as pair,
        ROUND(
            (COUNT(*) * SUM(Returns * Promo_Spend) - SUM(Returns) * SUM(Promo_Spend)) /
            (SQRT(COUNT(*) * SUM(Returns * Returns) - SUM(Returns) * SUM(Returns)) * 
             SQRT(COUNT(*) * SUM(Promo_Spend * Promo_Spend) - SUM(Promo_Spend) * SUM(Promo_Spend))
        ), 2) as correlation
    FROM retail_data
    
    UNION ALL
    
    -- Returns vs Net_Sales
    SELECT 
        'Returns-Net_Sales' as pair,
        ROUND(
            (COUNT(*) * SUM(Returns * Net_Sales) - SUM(Returns) * SUM(Net_Sales)) /
            (SQRT(COUNT(*) * SUM(Returns * Returns) - SUM(Returns) * SUM(Returns)) * 
             SQRT(COUNT(*) * SUM(Net_Sales * Net_Sales) - SUM(Net_Sales) * SUM(Net_Sales))
        ), 2) as correlation
    FROM retail_data
    
    UNION ALL
    
    -- Promo_Spend vs Net_Sales
    SELECT 
        'Promo_Spend-Net_Sales' as pair,
        ROUND(
            (COUNT(*) * SUM(Promo_Spend * Net_Sales) - SUM(Promo_Spend) * SUM(Net_Sales)) /
            (SQRT(COUNT(*) * SUM(Promo_Spend * Promo_Spend) - SUM(Promo_Spend) * SUM(Promo_Spend)) * 
             SQRT(COUNT(*) * SUM(Net_Sales * Net_Sales) - SUM(Net_Sales) * SUM(Net_Sales))
        ), 2) as correlation
    FROM retail_data
),

-- Find the strongest correlation by absolute value
strongest_correlation AS (
    SELECT 
        pair,
        correlation
    FROM correlations
    ORDER BY ABS(correlation) DESC
    LIMIT 1
)

SELECT * FROM strongest_correlation;