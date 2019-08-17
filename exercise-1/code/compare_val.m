%Step 6c
function [best_val,max_accuracy] = compare_val( TrainData, TrainDataTargets, TestData, TestDataTargets, architecture, training)
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);

	acc_val=[];
	prec_val=[];
	rec_val=[];
    acc_noval=[];
    prec_noval=[];
    rec_noval=[];
	
    %test performance with validate set
    net1 = newff(TrainD, TrainDT, architecture);
    
    %set given activation function 
    net1.trainFcn = training;
			
	%divide dataset into training and validation set
	net1.divideParam.trainRatio=0.8;
	net1.divideParam.valRatio=0.2;
	net1.divideParam.testRatio=0;
	net1.trainParam.epochs=1000;
	
    net1=train(net1,TrainD,TrainDT);
            
	%evaluate network
	TestDataOutput = sim(net1, TestD);
     
	[acc_val, prec_val, rec_val] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT)
		
    
     %test performance without validation set
    net2 = newff(TrainD, TrainDT, architecture);
    
    %set given activation function 
    net2.trainFcn = training;
			
	%divide dataset into training and validation set
	net2.divideParam.trainRatio=1;
	net2.divideParam.valRatio=0;
	net2.divideParam.testRatio=0;
	net2.trainParam.epochs=1000;
	
    net2=train(net2,TrainD,TrainDT);
            
	%evaluate network
	TestDataOutput = sim(net2, TestD);
     
	[acc_noval, prec_noval, rec_noval] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT)
 
    if(acc_val > acc_noval)
            best_val = 'with validation set';
            max_accuracy = acc_val;
    else
            best_val = 'without validation set';
            max_accuracy = acc_noval;
    end
    
      figure();
     bar([acc_val acc_noval]);
     title('Accuracies with/without Validation set');
     xlabel('Valiadation set');
     ylabel('Accuracy')
    
       figure();
     bar(prec_val);
     title('Precision with Validation set');
     xlabel('Valiadation set');
     ylabel('Precision'); 
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
     
       figure();
     bar(prec_noval);
     title('Precision without Validation set');
     xlabel('No Valiadation set');
     ylabel('Precision'); 
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
     
      figure();
     bar(rec_val);
     title('Recall with Validation set');
     xlabel('Valiadation set');
     ylabel('Recall'); 
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
     
      figure();
     bar(rec_noval);
    title('Recall without Validation set');
     xlabel(' No Valiadation set');
     ylabel('Recall'); 
     labs={'category 1','category 2','category 3','category 4','category 5'};
     set(gca,'XTick',1:5,'xticklabels',labs)
    
  
 end