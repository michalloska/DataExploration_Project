function conf_mtx = testClassification(input_all, clusterIdx_all, C_all, k, n)
    
    clusters_num = size(C_all, 1);
    conf_mtx_test = zeros(clusters_num, clusters_num);
    
    for tr = 1:n
        input = input_all;
        clusterIdx = clusterIdx_all;
        test_in = zeros(k, size(input, 2));
        test_t = zeros(k, 1);

        test_idx = k;
        while test_idx > 0
            idx = randi([1 size(input, 1)], 1, 1);

            test_in(test_idx,:) = input(idx,:);
            input(idx, :) = [];

            test_t(test_idx,:) = clusterIdx(idx,:);
            clusterIdx(idx,:) = [];
            test_idx = test_idx - 1;
        end

        [idx, C] = kmeans(input(:,:), clusters_num);
        [new_test_t, new_C] = fixTestTargetIndexes(C_all, C, test_t);

        result = classify(new_C, test_in);
        conf_mtx = applyToConfMtx(test_t, result, conf_mtx_test);
    end
end

function conf_mtx = applyToConfMtx(test_t, result, conf_mtx)
    for i = 1:size(test_t, 1)
        exp = test_t(i, 1);
        got = result(i, 1);
        
        if isnan(exp) || isnan(got)
            continue
        end
        conf_mtx(got, exp) = conf_mtx(got, exp) + 1;
    end
end

function result = classify(C, input)
    result = zeros(size(input, 1), 1);
    
    for i = 1:size(input, 1)
        closest_c_dist = Inf;
        closest_c_idx = 0;
        
        for j = 1:size(C, 1)
           d = sqrt(sum((input(i,:) - C(j,:)) .^ 2));
           if d < closest_c_dist
               closest_c_dist = d;
               closest_c_idx = j;
           end
        end
        result(i, 1) = closest_c_idx;
    end
end

function [new_test_t, new_C] = fixTestTargetIndexes(C_all, C, test_t)
    new_test_t = zeros(size(test_t,1), 1);
    new_C = C;
    
    for i = 1:size(C_all, 1)
       closest_dist = Inf;
       closest_idx = 0;
       
       for j = 1:size(C, 1)
           d = sqrt(sum((C_all(i,:) - C(j,:)) .^ 2));
           if d < closest_dist
               closest_dist = d;
               closest_idx = j;
           end
       end
       
       new_C(i,:) = C(closest_idx,:);
       
%        for idx = 1:size(test_t, 1)
%            if test_t(idx, 1) == closest_idx
%                new_test_t(idx, 1) = i;
%            elseif isnan(test_t(idx, 1))
%                new_test_t(idx, 1) = NaN;
%            end
%        end
    end
end