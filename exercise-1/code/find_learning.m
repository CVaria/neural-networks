%Step 6b
function [best_learning,max_accuracy] = find_learning( TrainData, TrainDataTargets, TestData, TestDataTargets, architecture, training)
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);

	acc_gd=[];
	prec_gd=[];
	rec_gd=[];
    acc_gdm=[];
    prec_gdm=[];
    rec_gdm=[];
	
    %test learngdm algorithm
    %net1 = newff(TrainD, TrainDT, architecture);
    net1 = newff(TrainD, TrainDT, architecture, {'tansig', 'tansig', 'purelin'}, training,'learngdm');
    
    %suitable activation function 
    %net1.trainFcn = training;
	%net1.biases{2}.learnFcn='learngdm'; ayto einai lathos????
			
	%divide dataset into training and validation set
	net1.divideParam.trainRatio=0.8;
	net1.divideParam.valRatio=0.2;
	net1.divideParam.testRatio=0;
	net1.trainParam.epochs=1000;
	
    net1=train(net1,TrainD,TrainDT);
            
	%evaluate network
	TestDataOutput = sim(net1, TestD);
     
	[acc_gdm, prec_gdm, rec_gdm] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT)
		
    
     %test learngd algorithm
    %net2 = newff(TrainD, TrainDT, architecture);
     net2 = newff(TrainD, TrainDT, architecture, {'tansig', 'tansig', 'purelin'}, training,'learngd');
    
    %suitable activation function 
    %net2.trainFcn = training;
	%net2.biases{2}.learnFcn='learngd';
			
	%divide dataset into training and validation set
	net2.divideParam.trainRatio=0.8;
	net2.divideParam.valRatio=0.2;
	net2.divideParam.testRatio=0;
	net2.trainParam.epochs=1000;
	
    net2=train(net2,TrainD,TrainDT);
            
	%evaluate network
	TestDataOutput = sim(net2, TestD);
     
	[acc_gd, prec_gd, rec_gd] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT)
 
    if(acc_gd > acc_gdm)
            best_learning = 'learngd';
            max_accuracy = acc_gd;
    else
            best_learning = 'learngdm';
            max_accuracy = acc_gdm;
    end
    
    
  %testing plots  
  figure();
  bar([acc_gdm acc_gd]);
  title('Accuracies based on learning algorithms');
  xlabel('Learning Algorithms');
  ylabel('Accuracy');
  labs={'learngdm','learngd'};
  set(gca,'XTick',1:2,'xticklabels',labs)
 
  figure();
  bar([prec_gdm prec_gd]);
  title('Precisions based on learning algorithms');
  xlabel('Learning Algorithms');
  ylabel('Precision');
  legend('learngdm','learngd');
  labs={'category 1','category 2','category 3','category 4','category 5'};
  set(gca,'XTick',1:5,'xticklabels',labs)
 
  figure();
  bar([rec_gdm rec_gd]);
  title('Recalls based on learning algorithms');
  xlabel('Learning Algorithms');
  ylabel('Recall');
  legend('learngdm','learngd');
  labs={'category 1','category 2','category 3','category 4','category 5'};
  set(gca,'XTick',1:5,'xticklabels',labs)
    
  
 end