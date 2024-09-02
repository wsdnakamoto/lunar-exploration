data_file=../../data/DTM_MAP_02_N15E303N12E306SC.img
grd_file_tmp=../../output/local_slope_map_DTM_tmp.grd
grd_file_tmp_2=../../output/local_slope_map_DTM_tmp_2.grd
grd_file=../../output/local_slope_map_DTM.grd
cpt_file=../../output/local_slope_map_DTM.cpt
ps_file=../../output/local_slope_map_DTM.ps
png_file=../../output/local_slope_map_DTM

R=-R303/306/12/15
J=-JQ0/0/15

# imgからgrdへ変換
gmt xyz2grd $data_file -G$grd_file_tmp -I12288+/12288+ $R -ZTLhw
#slopeの計算
gmt grdgradient $grd_file_tmp -S$grd_file_tmp_2 -D -M
#度に変換
gmt grdmath -fg $grd_file_tmp_2 ATAN PI DIV 180 MUL = $grd_file
# カラーパレットの作成
gmt grd2cpt $grd_file -Crainbow -E15 -L0/10 -D -Z > $cpt_file
# 地図を作成
gmt grdimage $grd_file $R $J -C$cpt_file -X2.5 -Y10.0 -Ba1f0.5g0.5::/a1f0.5g0.5::WSEN -P -K > $ps_file
# 等高線を追加
#gmt grdcontour $grd_file $J $R -C100 -Wred -O -K >> $ps_file
# スケールバーを追加
gmt psscale -Dx0.0c/-3.0c+w13c/0.7c+h -I0.4 -C$cpt_file --D_FORMAT=%.1lf -B2::/:"Slope [deg]": -O >> $ps_file
# PNGに変換
gmt ps2raster -Tg $ps_file -F$png_file
# 不要なファイルの削除
rm -f $cpt_file $grd_file_tmp $grd_file_tmp_2 $grd_file $ps_file gmt.history