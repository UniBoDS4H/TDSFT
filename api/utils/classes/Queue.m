% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION: Class which implements a simple queue data structure using cell array.
classdef Queue < handle      
    properties (Access = private)
        data = {} % cell array to store the queue elements
    end   

    methods
        % Constructor (empty)
        function q = Queue()
        end    

        % Adds an element to the queue
        % Parameters:
        %   q: queue object to which to enqueue
        %   item: element to enqueue
        function enqueue(q,item)
            q.data{end+1} = item;
        end

        % Removes the first element of the queue and returns it
        % Parameters:
        %   q: queue object from which to dequeue
        % Return:
        %   item: first element of the queue
        function item = dequeue(q)
            if !isempty(q.data)
                item = q.data(1);
                q.data = q.data(2:end);
            end
        end

        % Checks if the queue is empty
        % Parameters:
        %   q: queue object to check
        % Return:
        %   bool: true if the queue is empty, false otherwise
        function bool = isEmpty(q)
            bool = isempty(q.data);
        end
    end       
end