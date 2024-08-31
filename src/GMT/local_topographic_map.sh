data_file=../../data/lalt_topo_ver3.grd
cpt_file=../../output/local_topographic_map.cpt
ps_file=../../output/local_topographic_map.ps
png_file=../../output/local_topographic_map

R=-R303/306/12/15

# カラーパレットの作成
gmt grd2cpt $data_file -Crainbow -E30 -L-2/0 -D -Z > $cpt_file
# 地図を作成
gmt grdimage $data_file $R -JQ0/0/16 -X2.5 -Y9.0 -C$cpt_file -Jz0.2 -E360/360 -Ba1f0.5g0.5::/a1f0.5g0.5::WSEN -K -P > $ps_file
gmt psscale -Dx1.0c/-3.0c+w13c/0.7c+h -C$cpt_file -B0.5::/:"Elevation [km]": -O >> $ps_file
# PNG に変換
gmt ps2raster -Tg $ps_file -F$png_file
# 不要なファイルの削除
rm -f $cpt_file $ps_file gmt.history