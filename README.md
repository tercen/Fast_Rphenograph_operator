# fast rphenograph operator

##### Description

Implementation of the fast rphenograph algorithm.
The `rphenograph` operator performs a clustering of data (mainly flow cytometry) from the `Rphenograph` package.

##### Usage

Input projection|.
---|---
`row`   | represents the variables (e.g. channels, markers)
`col`   | represents the observations (e.g. cells) 
`y-axis`| is the value of measurement signal of the channel/marker


Input parameters|.
---|---
`k`   | integer, number of nearest neighbours (default: 30)
`seed`   | integer, random seed (default: NULL)

Output relations|.
---|---
`membership_num`| numeric, per column (e.g. per cell)
`membership_label`| character, per column (e.g. per cell)
`modularity_num`| numeric, per column (e.g. per cell)

##### Details

FastPG utilizes the same three main steps as the phenograph algorithm [@Levine-2015, @Chen-2016], but uses fast, parallel implementations.

The `Rphenograh` R package is a simple R implementation of the phenograph [PhenoGraph](http://www.cell.com/cell/abstract/S0092-8674(15)00637-6) algorithm, which is a clustering method designed for high-dimensional single-cell data analysis. It works by creating a graph ("network") representing phenotypic similarities between cells by calclating the Jaccard coefficient between nearest-neighbor sets, and then identifying communities using the well known [Louvain method](https://sites.google.com/site/findcommunities/) in this graph. 

##### See Also

[RphenoGraph package](https://github.com/i-cyto/Rphenograph).
[RphenoGraph operator](https://github.com/tercen/rphenograph_operator)

