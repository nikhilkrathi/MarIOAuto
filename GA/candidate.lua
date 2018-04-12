--Candidate File

gen_candidate = {
    time = 0,
    fitness = 0, 
    has_won = false,
    been_modified = true,
    win_time = 0
}
gen_candidate.__index = gen_candidate;

function gen_candidate.new()
    local self = setmetatable({}, gen_candidate);
    self.inputs = {};
    self.input_fit = {};
    return self;
end

function generate_candidates(num_cands, num_controls)
end

function generate_input()
end