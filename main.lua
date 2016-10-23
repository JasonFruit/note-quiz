local staff_top = 50;
local staff_spacing = 20;
local x_offset = 280;
local staff_bottom;

local notes = {"e", "f", "g", "a", "b", "c", "d", "e", "f", "g"};

local note = 0;

function love.load()
   math.randomseed(os.time());
   note = random_note();
   wah = love.audio.newSource("sad-trombone.mp3", "static");
   tada = love.audio.newSource("tada.mp3", "static");
end

function love.update(time_elapsed)
   
end

function random_note()
   local out = math.random(1, table.getn(notes));
   if out ~= note then
      return out;
   else
      return random_note();
   end
end

function draw_clef(x, clef)
   -- this makes a very ugly treble clef
   if clef == "treble" then
      love.graphics.line(x, staff_top - staff_spacing,
			 x, staff_bottom + staff_spacing * 2);
      love.graphics.arc("line", x, staff_top, staff_spacing, 0 - math.pi / 2, math.pi / 2, 100);
      love.graphics.arc("line", x, staff_top + staff_spacing * 3, staff_spacing * 2, math.pi / 2, math.pi * 1.5, 100)
            love.graphics.arc("line", x, staff_top + staff_spacing * 4, staff_spacing, 0 - math.pi / 2, math.pi / 2, 100);
   end
end

function draw_note(x, pitch, duration)
   local mode;
   
   if duration < 3 then
      mode = "line";
   else
      mode = "fill";
   end

   y = staff_bottom - (staff_spacing / 2) * (pitch - 1);
   
   love.graphics.ellipse(mode, x, y, staff_spacing * .7, staff_spacing / 2);
   
end

function love.draw()
   local i;
   local y;

   local width = love.graphics.getWidth();
   local height = love.graphics.getHeight();

   for i = 1,5 do
      
      y = staff_top + i * staff_spacing;
      love.graphics.line(x_offset, y, width - x_offset, y);

   end

   staff_bottom = y;

   draw_clef(x_offset + staff_spacing * 2, "treble");

   draw_note(x_offset + 100, note, 2);

end

function love.mousepressed(x, y, button, istouch)

end

function is_note(key)
   for _, v in pairs(notes) do
      if key == v then return true end
   end

   return false;
   
end

function love.keypressed(key)
   

   if not is_note(key) then
      
   elseif key == notes[note] then
      love.audio.stop()
      love.audio.play(tada);
      note = random_note();
   else
      love.audio.stop()
      love.audio.play(wah);
   end
end

function love.keyreleased(key)

end

function love.focus(focused)

end

function love.quit()

end
