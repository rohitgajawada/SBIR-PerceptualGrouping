function OptimalLabels = GestaltGroupRsvm( ConSegList,RelativeImp,C,seeds )

if nargin<5
    seeds = [1:size(ConSegList,2)]';
end

graph =  GraphConstructRsvm( ConSegList,seeds );
OptimalLabels = ToolGraphCutsRsvm( graph, ConSegList,RelativeImp,C,seeds);

end

