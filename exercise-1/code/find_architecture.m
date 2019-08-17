
%Step 4 and 5
function max_accuracy = find_architecture( TrainData, TrainDataTargets, TestData, TestDataTargets, training)
    [TestD, TestDT, TrainD, TrainDT] = preprocess(TestData, TestDataTargets, TrainData, TrainDataTargets);
    
%training choices: traingdx, trainlm, traingd, traingda
    a=[];
	accuracy=[];
	precision=[];
	recall=[];
	
	for layer2 = 0:5:30
		for layer1=5:5:30
			%create neural network with suitable architecture
			if(layer2==0)
				net = newff(TrainD, TrainDT, [layer1]);
			else
				net = newff(TrainD, TrainDT, [layer1 layer2]);
            end
			
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
            i=layer1/5;
            j=layer2/5;
			[accuracy(i, j+1), precision(i,:), recall(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDT);
		end
    end
    accuracy
    precision
    recall
   [max_accuracy,Index] = max(accuracy(:))
   [I_row, I_col] = ind2sub(size(accuracy),Index)
   
   
    x=5:5:30;
    bar(x,accuracy);
    xlabel('Number of neurons on first hidden level.');
    ylabel('Accuracy');
    legend('[x]','[x 5]' ,'[x 10]', '[x 15]', '[x 20]', '[x 25]', '[x 30]');
    title('Accuracy based on architecture');
 end