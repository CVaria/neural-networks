function [TestData, TestDataTargets, TrainData, TrainDataTargets] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets)
%Step 1: Find out how many Data tests there are in each category
sum_data = sum(TrainDataTargets,2);
%show_data = bar([1 2 3 4 5], sum_data);
%Step 2: Keep certain number of targets in each category 
k = min(sum_data);
indexes =[];

for i = 1:5
    indexes = [indexes find(TrainDataTargets(i,:),k)];
end

% size(indexes,2) returns the number of columns
% so randperm returns a permutation of columns 
permutation = randperm(size(indexes,2));
%shuffle targets based on permutation
indexes = indexes(permutation);
%choose targets of previous positions
TrainData = TrainData(:,indexes);
TrainDataTargets = TrainDataTargets(:,indexes);

%Step 3: Remove constant rows from TrainData and TestData
[TrainData, settings1] = removeconstantrows(TrainData);
TestData = removeconstantrows('apply', TestData, settings1);

%Step 4: Use mapstd to map datas mean and standard devariation to 0 and 1
%respectively

[TrainData , settings2] = mapstd(TrainData);
TestData = mapstd('apply', TestData, settings2);

%Step 5: Use processpca to reduce data without losing information
%to synolo ton sysxetizomenon timon ginetai grammika asysxetistes
[TrainData, settings3] = processpca(TrainData, 0.002);
TestData = processpca('apply', TestData, settings3);
