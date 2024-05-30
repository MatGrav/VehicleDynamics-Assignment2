classdef (Enumeration) Tests < uint32
    enumeration
        cruise_control (1)
        tip_in (2)
        tip_off (4)
        motor_on (8)
        emergency_braking (16)
        regen_braking (32)
        regen_braking_with_acceleration (64)
        regen_braking_with_rep_acceleration (128)
        tyre_relaxation_disabled (256)
        % ABS_disabled (512)
        % EBD_disabled (1024)
    end
end