within PlanarMechanics.Sensors;
model AbsoluteVelocity
  "Measure absolute velocity vector of origin of frame connector"
  extends Internal.PartialAbsoluteSensor;

  Modelica.Blocks.Interfaces.RealOutput v[3](
    each final quantity="Velocity",
    each final unit = "m/s")
    "Absolute velocity vector resolved in frame defined by resolveInFrame"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={110,0})));
  Interfaces.Frame_resolve frame_resolve if
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve
    "Coordinate system in which output vector v is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100}),
        iconTransformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which output vector v shall be resolved (1: world, 2: frame_a, 3: frame_resolve)";

protected
  Internal.BasicAbsolutePosition position(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Continuous.Der der1[3] annotation (Placement(transformation(
        extent={{-10,-10},{10,10}})));
  TransformAbsoluteVector transformAbsoluteVector(
    frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world,
    frame_r_out=resolveInFrame) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,0})));
  Interfaces.ZeroPosition zeroPosition
    annotation (Placement(transformation(extent={{-60,-60},{-80,-40}})));
  Interfaces.ZeroPosition zeroPosition1 if not (
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
equation
  connect(position.r, der1.u) annotation (Line(
      points={{-39,0},{-12,0}},
      color={0,0,127}));
  connect(position.frame_a, frame_a) annotation (Line(
      points={{-60,0},{-70,0},{-70,0},{-80,
          0},{-80,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(der1.y, transformAbsoluteVector.r_in) annotation (Line(
      points={{11,0},{38,0}},
      color={0,0,127}));
  connect(transformAbsoluteVector.r_out, v) annotation (Line(
      points={{61,0},{56,0},{56,0},{110,0}},
      color={0,0,127}));
  connect(zeroPosition.frame_resolve, position.frame_resolve) annotation (Line(
      points={{-60,-50},{-50,-50},{-50,-10}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_a, frame_a) annotation (Line(
      points={{50,10},{50,20},{-70,20},{-70,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(transformAbsoluteVector.frame_resolve, zeroPosition1.frame_resolve)
    annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{60,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_resolve, frame_resolve) annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{0,-50},{0,-100}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{70,0},{100,0}},
          color={0,0,127}),
        Text(
          extent={{58,48},{142,18}},
          textString="v"),
        Text(
          extent={{15,-67},{146,-92}},
          lineColor={95,95,95},
          textString="resolve"),
        Line(
          points={{0,-70},{0,-95}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>",  info="<html>
<p>The absolute velocity vector of the origin of frame_a is determined and provided at the output signal connector <b>v</b>.</p>
<p>Via parameter <b>resolveInFrame</b> it is defined, in which frame the velocity vector is resolved: </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><h4>resolveInFrame =</h4></p><p align=\"center\">Types.ResolveInFrameA.</p></td>
<td><p align=\"center\"><h4>Meaning</h4></p></td>
</tr>
<tr>
<td valign=\"top\"><p>world</p></td>
<td valign=\"top\"><p>Resolve vector in world frame</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_a</p></td>
<td valign=\"top\"><p>Resolve vector in frame_a</p></td>
</tr>
<tr>
<td valign=\"top\"><p>frame_resolve</p></td>
<td valign=\"top\"><p>Resolve vector in frame_resolve</p></td>
</tr>
</table>
<p>If <code>resolveInFrame = Types.ResolveInFrameA.frame_resolve</code>, the conditional connector &quot;frame_resolve&quot; is enabled and v is resolved in the frame, to which frame_resolve is connected. Note, if this connector is enabled, it must be connected.</p>
<p>Example: If <code>resolveInFrame = Types.ResolveInFrameA.frame_resolve</code>, the output vector is computed as: </p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-x2brh9fX.png\" alt=\"
v0 = der([x,y,phi])\"></p>
<p><br/><img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-Kgd1NoyE.png\" alt=\"v = [cos(frame_resolve.phi), sin(frame_resolve.phi),0;-sin(frame_resolve.phi),cos(frame_resolve.phi),0;0,0,1] * [v0[1];v0[2];v0[3]]\"></p>
<p>where <img src=\"modelica://PlanarMechanics/Resources/Images/equations/equation-zBL2JSRi.png\" alt=\"[x,y,phi]\"> is position and angle vector of origin of frame_a resolved in world coordinate.</p>
</html>"));
end AbsoluteVelocity;
