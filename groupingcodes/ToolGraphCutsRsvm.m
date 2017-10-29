function OptimalLabels = ToolGraphCutsRsvm( graph, ConSegList,RelativeImp,C,seeds )

NumSites = size(ConSegList,2);
NumLabels = size(seeds,1);

if NumSites == 1
    OptimalLabels = 1;
else
    
h = GCO_Create(NumSites,NumLabels);

DatacostArray = ConstructDatacostRsvm( ConSegList,RelativeImp,seeds);
SmoothnesscostArray = ConstructSmoothnessRsvm(graph,seeds);
labelcost = C*floor(sum(DatacostArray,2)/(NumSites));

GCO_SetDataCost(h,int32(DatacostArray));
GCO_SetSmoothCost(h,int32(SmoothnesscostArray));
GCO_SetLabelCost(h,int32(labelcost));

GCO_Expansion(h);
OptimalLabels = GCO_GetLabeling(h);
GCO_Delete(h);

end
end

