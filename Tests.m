classdef (Enumeration) Tests < uint32
    enumeration
        cruise_control (1)
        tip_in (2)
        tip_off (4)
        motor_on (8)
        emergency_braking (16)
        regen_braking (32)
    end
end