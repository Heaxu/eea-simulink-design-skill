function results = find_simulink_blocks(keyword, libraries)
%FIND_SIMULINK_BLOCKS Search common Simulink libraries for block names.

arguments
    keyword (1, :) char
    libraries cell = {'simulink', 'powerlib', 'ee_lib'}
end

libraryNames = {};
blockNames = {};
blockPaths = {};

escapedKeyword = regexptranslate('escape', keyword);
pattern = ['.*' escapedKeyword '.*'];

for libraryIndex = 1:numel(libraries)
    library = libraries{libraryIndex};

    try
        load_system(library);
    catch
        continue;
    end

    findOptions = { ...
            'LookUnderMasks', 'all', ...
            'FollowLinks', 'on', ...
            'RegExp', 'on'};
    searchArgs = {'Name', pattern};

    try
        matches = find_system(library, findOptions{:}, ...
            'MatchFilter', @Simulink.match.allVariants, searchArgs{:});
    catch
        matches = find_system(library, findOptions{:}, searchArgs{:});
    end

    try
        matches = matches(:);
    catch
        continue;
    end

    for matchIndex = 1:numel(matches)
        blockPath = matches{matchIndex};
        libraryNames{end + 1, 1} = library; %#ok<AGROW>
        blockNames{end + 1, 1} = get_param(blockPath, 'Name'); %#ok<AGROW>
        blockPaths{end + 1, 1} = blockPath; %#ok<AGROW>
    end
end

results = table(libraryNames, blockNames, blockPaths, ...
    'VariableNames', {'Library', 'BlockName', 'BlockPath'});
end
