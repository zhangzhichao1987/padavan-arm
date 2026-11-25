##################################################################
# Board PID      # Board Name     # PRODUCT # Note
##################################################################
# 360T7-NAND     # 360T7-NAND     # MT7981  # 108M NAND, MT7976CN
##################################################################

CFLAGS += -DBOARD_360T7_NAND -DBOARD_MT7915_DBDC
BOARD_NUM_USB_PORTS=1
CONFIG_BOARD_RAM_SIZE=128

USE_IPV6=1
