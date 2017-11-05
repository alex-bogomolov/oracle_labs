 SELECT investments.id, investments.name, investment_data.id FROM investments
    INNER JOIN investment_data ON investment_data.investment_id = investments.id;

/