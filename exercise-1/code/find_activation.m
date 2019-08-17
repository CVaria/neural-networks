%Step 6a
function [accuracy, precision, recall]= find_activation( TrainData, TrainDataTargets, TestData, TestDataTargets, architecture, training, activation)
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);
   
	accuracy=[];
	precision=[];
	recall=[];
	
	%activation  choices: hardlim, tansig, logsig, purelin
	
	%create neural network with suitable architecture
	net = newff(TrainD, TrainDT, architecture); 
        
    %set given training and activation function 
    net.trainFcn = training;
    %thats only for output layer, default for hidden layers is 'tansig'
    net.layers{2}.transferFcn=activation;
			
	%divide dataset into training and validation set
	net.divideParam.trainRatio=0.8;
	net.divideParam.valRatio=0.2;
	net.divideParam.testRatio=0;
	net.trainParam.epochs=1000;
    
    net=train(net,TrainD,TrainDT);
            
	%evaluate network
	TestDataOutput = sim(net, TestD);
     
	[accuracy, precision, recall] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT);

    
    %just plots
     figure();
     bar(precision);
     title(activation);
     %xlabel('Categories');
     ylabel('Precision');
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
     
     
     figure();
     bar(recall);
     title(activation);
     %xlabel('Categories');
     ylabel('Recall');
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
 

 end