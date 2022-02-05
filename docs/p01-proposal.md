# **Analyzing Government Food Support in New York**
## **Project Proposal**
### Authors:
| Name | Email
| -----|------
| Paul Kim | pkim3@uw.edu
| Mason Howes | mhowes@uw.edu
| Viru Repalle | virurep@uw.edu
|Matthew Pedraja|mpedraj@uw.edu

### **Date**: February 4th 2021

### **Affiliation**:
**INFO-201: Technical Foundations of Informatics - The Information School - University of Washington**

<p align="center">
  <img src="https://static01.nyt.com/images/2010/01/22/arts/22stamps1a/popup.jpg?quality=75&auto=webp&disable=upscale">
</p>

### **Abstract**:
We are concerned with changes to SNAP assistance given to individuals and families in need. This is a topic of concern because analyzing how the SNAP program has changed based on various relevant factors can help policy makers make more informed decisions on an important part of United States welfare to low-income parties. We plan to do this by analyzing a data set which has the amount of SNAP assistance given to families over time within the State of New York.

### **Keywords**:
_food insecurity, low income meals, SNAP access, government food support_

### **Introduction**:
Our group’s project focuses on the change in number of persons who utilize SNAP within the different districts of the State of New York over the past 5 years to confirm whether or not the necessary parties are receiving the help that they need. We all believe that no one should have to worry about whether or not there will be food on the table each night, so SNAP, the Supplemental Nutrition Assistance Program, is something that each of us is passionate about for its success and ease of access. With this project, we hope to gain a better understanding of its impact on people’s lives as well as to see whether or not the U.S. government is holding up their end on allowing residents of a selected State, being New York in this case, to have affordable food to feed their families. Finally, we aim for this information to be more publicized to potentially make a difference if need be.

### **Design Situation**:

**Framing the Topic of Concern**: Our choice of topic for this project focuses on food security and the support that is provided within the districts of New York by the U.S government, from November 2015 to June 2020. Each district contains the amount of households from each specific month, as well as provides statistics on the amount of support that was given within that district, through the SNAP (Supplemental Nutrition Assistance Program). The key issues to our topic surround economical and financial problems, with the Covid-19 pandemic affecting everyone globally, as well as issues of job security affecting income making food harder to access.
<p align="center">
  <img src="https://www.scarymommy.com/wp-content/uploads/2017/05/hungry-child.jpg">
</p>

**Human Values**: Values associated and connected with our topic is maintaining the well-being of our community and the right to having access to food, making sure no one is deprived of that necessity, and raising awareness on the issues of hunger. These values originate from social and economical issues that have arised especially in the 21st century regarding the financial crises and Covid-19 pandemic, with over 10.5% of households having experienced food insecurity in the United States alone in 2019 ([Silva, 2020](https://www.npr.org/2020/09/27/912486921/food-insecurity-in-the-u-s-by-the-numbers. )). The issue of healthy foods in itself being expensive for an individual to sustain conflicts with the idea of providing food for everyone, which results in food insecurity ([Food and Agriculture Organization of the United Nations, 2021](https://www.fao.org/state-of-food-security-nutrition
)).

**Stakeholders**: The direct stakeholders of our topic involves not only the citizens and residents of New York, but also other residents in different states that are experiencing food insecurity and are in need of SNAP benefits and other community based organizations, such as food banks and retail shops that provide food items for those who need it. The motivations and values the stakeholders contain is dealing and solving issues of hunger for everyone, and maintaining the well-being of the communities. Indirect stakeholders include politicians who cater to the people they are serving in order to maintain their status within the government through elections and provide assistance for struggling individuals.

**Benefits and Harms**: The potential benefits by exploring our topic involve raising support in favor of making sure everyone is able to have food, greatly benefiting every individual in need of food as well as every citizen by reducing the stress of food insecurity ([Keith-Jennings, 2019](https://www.cbpp.org/blog/raising-snap-benefits-would-have-powerful-effects-on-food-security-poverty-health)). However, potential harms could involve using the data provided as a means to push a political agenda and attack the political party associated, leading to a huge divide amongst the populace discouraging cooperation against solving hunger issues.

### **Research Questions**:
1. Which month(s) historically have the most Total SNAP benefits allocated to them?
2. How does the number of SNAP receiving persons change throughout time? This can be categorized by NY as a whole or by individual districts as well
3. How did COVID-19 affect the number of SNAP benefits being distributed?
4. Does the number of households in a district correlate with the number of SNAP benefits being allocated in said district?

### **The Dataset**:
**Size**: The dataset we chose has 14 columns and 13.9 thousand rows. Overall, it is a larger dataset because it has a lot of columns that are applied to thousands of rows.

**Complexity**: This is a complex dataset because it contains several features that apply to a significant amount of observations. The features go in depth in several different ways. One way is that the information is sorted by districts; this sorting offers a deeper perspective that is location based. Additionally, the data goes into higher detail by specifying if the SNAP data is temporary or non-temporary. If the data is temporary then it invokes the possibility of change in the future: a sign of growth and positive change. The aforementioned data is continued to be divided into three subsections each. They have data related to households, individual persons, and the total benefits. Households give a larger summary while the person data is more scrutinous and focuses on the individual. The benefits present a conglomeration of the prior sets and shows the impact of the food assistance program. Overall, the dataset is split up by months of the year. This organization provides for a structured way to view the data. It can be analyzed to see the difference made each month.

**Origins**: This dataset comes from the U.S. Government and it represents the number of people in the state of New York who are under the food assistance program. The observations are the number of people per month and distract who are in the specified columns provided. The data was collected by New York State Office of Temporary and Disability Assistance to asses the amount of food rationing that was being spent by the government. This data benefits the government because they are the ones who are spending the money on the food assistance. Therefore it would be useful to use this data to tack their spendings. By tracking their spending they are able to asses if they need to allocate more or less money in coming years, enabling them the view and predict patterns. If correctly used they can find ways to save their money. The data is validated by New York City and Upstate Welfare Management Systems and it is published by the U.S. Government so it is reasonable to say this data is trustworthy. We obtained this data from the New York government data website.
### **Expected Implications**:
Given that our Research questions are answered, we would be able to see when the highest amount of SNAP assistance is given out to families. An expected implication of answering this question can include better preparation of government resources for the SNAP program when it is at its busiest. Essentially, knowing when the program is the busiest can help governmental planners in ensuring the program is well staffed. Understanding how the count of SNAP receiving individuals, either by NY district or as the whole state, changes over time can be an indication of the SNAP program's use over time. If it's found that SNAP program individuals are dropping throughout time, government planners may be able to downsize the program to allocate resources in a different area without compromising the effectiveness of the program. Overall, the answers to our questions can help policy makers make better informed decisions regarding the SNAP program, hopefully improving its effectiveness.
### **Limitations**:
For one, we are always limited by our particular dataset. Given that our dataset focuses on the State of NY, it will be difficult to answer broader questions relating to the SNAP program across the nation. This can be potentially addressed though applying the data to similar metropolitan areas with similar levels of SNAP receiving individuals, though in reality every state is most likely different in these variables. The dataset additionally does not progrive information regarding which specific foods the SNAP program helps provide. insight on the food types bought by the individuals receiving SNAP assistance therefore will not be possible to find. This may be addressed through finding surveys which include data on the foods bought with SNAP funds, but this type of data may prove difficult to find.

### **References**:

>New York State Office of Temporary and Disability Assistance. (2022, January 31). Supplemental Nutrition Assistance Program (SNAP) caseloads and expenditures: Beginning 2002: State of New York. Supplemental Nutrition Assistance Program (SNAP) Caseloads and Expenditures: Beginning 2002 | State of New York. Retrieved February 5, 2022, from https://data.ny.gov/Human-Services/Supplemental-Nutrition-Assistance-Program-SNAP-Cas/dq6j-8u8z

>Silva, Christianna. “Food Insecurity in the U.S. by the Numbers.” NPR, NPR, 27 Sept. 2020, https://www.npr.org/2020/09/27/912486921/food-insecurity-in-the-u-s-by-the-numbers.

>“The State of Food Security and Nutrition in the World 2021.” Www.fao.org, 2021, https://www.fao.org/state-of-food-security-nutrition

 >Keith-Jennings , Brynne. “Raising SNAP Benefits Would Have Powerful Effects on Food Security, Poverty, Health.” Center on Budget and Policy Priorities, 12 Aug. 2019, https://www.cbpp.org/blog/raising-snap-benefits-would-have-powerful-effects-on-food-security-poverty-health
