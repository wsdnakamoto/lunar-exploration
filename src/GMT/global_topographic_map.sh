data_file=../../data/lalt_topo_ver3.grd
cpt_file=../../output/global_topographic_map.cpt
ps_file=../../output/global_topographic_map.ps
png_file=../../output/global_topographic_map

# カラーパレットの作成
gmt grd2cpt $data_file -Crainbow -E30 -L-9/9 -D -Z > $cpt_file
# 地図を作成
gmt grdimage $data_file -Rd -JQ0/0/25 -X2.5 -Y6.0 -C$cpt_file -Jz0.2 -E360/360 -Ba30f15g15::/a30f15g15::WSEN -K > $ps_file
gmt psscale -Dx1.0c/-4.0c+w20c/1.0c+h -C$cpt_file -B2::/:"Elevation [km]": -O >> $ps_file
# PNG に変換
gmt ps2raster -Tg $ps_file -F$png_file
# 不要なファイルの削除
rm -f $cpt_file $ps_file gmt.history