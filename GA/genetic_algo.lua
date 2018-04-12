--Genetic Algorithm File

require "candidate"
require "other_utils"

function ga_crossover(tbl, topperc)
    --extract top x perc from table
    local top = {};
    local top_max_ind = math.floor(topperc*(#tbl));
    local top_max_cont = #(tbl[1].inputs);
    for i=1, top_max_ind do
        top[i] = gen_candidate.new();
        for j=1, top_max_cont do
            top[i].inputs[j] = deepcopy(tbl[i].inputs[j]);
            top[i].input_fit = tbl[i].input_fit;
        end
    end
end


function ga_mutate(tbl, count, mutation_rate)
end