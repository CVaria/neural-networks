%Step 4 and 5 but you simulate only one type of architecture
function accuracy = find_architecture_random( TrainData, TrainDataTargets, TestData, TestDataTargets, architecture, training)
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);

 
%training choices: traingdx, trainlm, traingd, traingda
    a=[];
	accuracy=[];
	precision=[];
	recall=[];
	

    %create neural network with given architecture
    net = newff(TrainD, TrainDT, architecture);
			
   if training ~= 0
        net.trainFcn = training;   
   end 
            
	%divide dataset into training and validation set
	net.divideParam.trainRatio=0.8;
	net.divideParam.valRatio=0.2;
	net.divideParam.testRatio=0;
	net.trainParam.epochs=1000;
	net=train(net,TrainD,TrainDT);
            
	%evaluate network
	TestDataOutput = sim(net, TestD);
	[accuracy, precision, recall] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT);
	
    accuracy
    precision
    recall
    
    
     %just plots
     figure();
     bar(precision);
     title('Precision with preprocess');
     %xlabel('Categories');
     ylabel('Precision');
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
     
     
     figure();
     bar(recall);
     title('Recall with preprocess');
     %xlabel('Categories');
     ylabel('Recall');
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
 
    
 end