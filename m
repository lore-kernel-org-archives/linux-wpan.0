Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35063 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeHWUtx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Aug 2018 16:49:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so3116487pfh.2
        for <linux-wpan@vger.kernel.org>; Thu, 23 Aug 2018 10:19:10 -0700 (PDT)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC 1/3 net] lorawan: Add LoRaWAN class module
Date: Fri, 24 Aug 2018 01:15:41 +0800
Message-Id: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
In-Reply-To: <cover.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "contact@snootlab.com" <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter ROBYNS <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>

LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.

This patch implements part of Class A end-devices features defined in
LoRaWAN(TM) Specification Ver. 1.0.2:
1. End-device receive slot timing
2. Only single channel and single data rate for now
3. Unconfirmed data up/down message types
4. Encryption/decryption for up/down link data messages

It also implements the the functions and maps to Datagram socket for
LoRaWAN unconfirmed data messages.

On the other side, it defines the basic interface and operation
functions for compatible LoRa device drivers.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 include/linux/maclorawan/lora.h | 239 +++++++++++
 net/maclorawan/Kconfig          |  14 +
 net/maclorawan/Makefile         |   2 +
 net/maclorawan/lorawan.h        | 219 ++++++++++
 net/maclorawan/lrwsec.c         | 237 +++++++++++
 net/maclorawan/lrwsec.h         |  57 +++
 net/maclorawan/mac.c            | 552 +++++++++++++++++++++++++
 net/maclorawan/main.c           | 665 ++++++++++++++++++++++++++++++
 net/maclorawan/socket.c         | 700 ++++++++++++++++++++++++++++++++
 9 files changed, 2685 insertions(+)
 create mode 100644 include/linux/maclorawan/lora.h
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/lorawan.h
 create mode 100644 net/maclorawan/lrwsec.c
 create mode 100644 net/maclorawan/lrwsec.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/main.c
 create mode 100644 net/maclorawan/socket.c

diff --git a/include/linux/maclorawan/lora.h b/include/linux/maclorawan/lora.h
new file mode 100644
index 000000000000..228160bf0691
--- /dev/null
+++ b/include/linux/maclorawan/lora.h
@@ -0,0 +1,239 @@
+/*-
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    similar to the "NO WARRANTY" disclaimer below ("Disclaimer") and any
+ *    redistribution must be conditioned upon including a substantially
+ *    similar Disclaimer requirement for further binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF NONINFRINGEMENT, MERCHANTIBILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY,
+ * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#ifndef __LRW_H__
+#define __LRW_H__
+
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/random.h>
+
+/* List the role of the LoRaWAN hardware */
+enum {
+	LRW_GATEWAY,
+	LRW_CLASS_A_NODE,
+	LRW_CLASS_B_NODE,
+	LRW_CLASS_C_NODE,
+};
+
+/* List the regions */
+enum {
+	LRW_EU863_870,
+	LRW_US902_928,
+	LRW_CN779_787,
+	LRW_EU443,
+	LRW_AU915_928,
+	LRW_CN470_510,
+	LRW_AS923,
+	LRW_KR920_923,
+	LRW_INDIA865_867,
+	LRW_MAX_REGION,
+};
+
+enum {
+	LRW_LORA,
+	LRW_FSK,
+};
+
+#define	LRW_UPLINK		0
+#define	LRW_DOWNLINK		1
+
+#define	LRW_DEVADDR_LEN		(sizeof(__le32))
+
+/* List the message types of LoRaWAN */
+enum {
+	LRW_JOIN_REQUEST,
+	LRW_JOIN_ACCEPT,
+	LRW_UNCONFIRMED_DATA_UP,
+	LRW_UNCONFIRMED_DATA_DOWN,
+	LRW_CONFIRMED_DATA_UP,
+	LRW_CONFIRMED_DATA_DOWN,
+	LRW_RFU,
+	LRW_PROPRIETARY,
+};
+
+enum {
+	LRW_ADDR_APPEUI,
+	LRW_ADDR_DEVEUI,
+	LRW_ADDR_DEVADDR,
+};
+
+struct lrw_addr_in {
+	int addr_type;
+	union {
+		u64 app_eui;
+		u64 dev_eui;
+		u32 devaddr;
+	};
+};
+
+struct sockaddr_lorawan {
+	sa_family_t family; /* AF_LORAWAN */
+	struct lrw_addr_in addr_in;
+};
+
+/* List the LoRa device's states of LoRaWAN hardware */
+enum {
+	LRW_STOP,
+	LRW_START,
+	LRW_STATE_IDLE,
+	LRW_STATE_TX,
+	LRW_STATE_RX,
+	LRW_STATE_CAD,
+};
+
+/**
+ * lrw_hw - This structure holds the LoRa device of LoRaWAN hardware.
+ *
+ * @parent:		points to the parent device
+ * @priv:		points to the private data
+ * @channels:		bits array of RF channels could be used
+ * @tx_powers:		points to the emitting RF power array
+ * @tx_powers_size:	the size of emitting RF power array in bytes
+ * @transmit_power:	the current emitting RF power in mBm
+ */
+struct lrw_hw {
+	struct device *parent;
+	void *priv;
+	u32 channels;
+	u8 current_channel;
+	s32 *tx_powers;
+	size_t tx_powers_size;
+	s32 transmit_power;
+};
+
+/**
+ * lrw_operations - Lists the LoRaWAN device/interface's operations.
+ * These are callback functions for the LoRaWAN module.  Compatible LoRa device
+ * driver should implement some of them according to the usage.  The
+ * unimplemented callback functions must be assigned as NULL.
+ *
+ * @start:
+ *	called when the interface is being up state
+ *
+ * @stop:
+ *	called when the interface is being down state
+ *
+ * @xmit_async:
+ *	called to xmit the data through the interface asynchronously
+ *
+ * @set_txpower:
+ *	called to set xmitting RF power in mBm of the interface
+ *
+ * @set_frq:
+ *	called to set carrier frequency Hz of the interface
+ *
+ * @set_bw:
+ *	called to set RF bandwidth in Hz of the interface
+ *
+ * @set_mod:
+ *	called to set the LoRa device's working mode: LoRa or FSK mode
+ *
+ * @set_sf:
+ *	called to set the CSS modulation's spreading factor of LoRa
+ *
+ * @start_rx_window:
+ *	called to ask the LoRa device open a receiving window
+ *
+ * @set_state:
+ *	called to set the LoRa device's working state
+ *
+ * @get_state:
+ *	called to get the LoRa device's current working state
+ */
+struct lrw_operations {
+	int (*start)(struct lrw_hw *);
+	void (*stop)(struct lrw_hw *);
+
+	int (*xmit_async)(struct lrw_hw *, struct sk_buff *);
+	int (*set_txpower)(struct lrw_hw *, s32);
+	int (*set_frq)(struct lrw_hw *, u32);
+	int (*set_bw)(struct lrw_hw *, u32);
+	int (*set_mod)(struct lrw_hw *, u8);
+	int (*set_sf)(struct lrw_hw *, u8);
+	int (*start_rx_window)(struct lrw_hw *, u32);
+
+	/* Set & get the state of the LoRa device. */
+	int (*set_state)(struct lrw_hw *, u8);
+	int (*get_state)(struct lrw_hw *, u8);
+};
+
+struct lrw_hw *lrw_alloc_hw(size_t, struct lrw_operations *);
+void lrw_free_hw(struct lrw_hw *);
+int lrw_register_hw(struct lrw_hw *);
+void lrw_unregister_hw(struct lrw_hw *);
+int lrw_set_region(struct lrw_hw *, u8);
+void lrw_rx_irqsave(struct lrw_hw *, struct sk_buff *);
+void lrw_xmit_complete(struct lrw_hw *, struct sk_buff *);
+
+static inline void lrw_random_addr(__le64 *addr)
+{
+	get_random_bytes(addr, sizeof(__le64));
+}
+
+void lrw_set_deveui(struct lrw_hw *, __le64);
+__le64 lrw_get_deveui(struct lrw_hw *);
+void lrw_set_appeui(struct lrw_hw *, __le64);
+__le64 lrw_get_appeui(struct lrw_hw *);
+void lrw_set_devaddr(struct lrw_hw *, __le32);
+__le32 lrw_get_devaddr(struct lrw_hw *);
+
+enum {
+	LRW_APPKEY,
+	LRW_NWKSKEY,
+	LRW_APPSKEY,
+};
+
+#define	LRW_KEY_LEN		16
+
+struct lrw_key {
+	int type;
+	u8 key[LRW_KEY_LEN];
+};
+
+int lrw_set_key(struct lrw_hw *, u8, u8 *, size_t);
+
+/* Need to find a way to define or assign */
+#define	LORAWAN_MTU		20
+
+#define	le32_to_be32(n)		(cpu_to_be32(le32_to_cpu(n)))
+#define	be32_to_le32(n)		(cpu_to_le32(be32_to_cpu(n)))
+#define	le64_to_be64(n)		(cpu_to_be64(le64_to_cpu(n)))
+#define	be64_to_le64(n)		(cpu_to_le64(be64_to_cpu(n)))
+
+#endif
diff --git a/net/maclorawan/Kconfig b/net/maclorawan/Kconfig
new file mode 100644
index 000000000000..741992b059c6
--- /dev/null
+++ b/net/maclorawan/Kconfig
@@ -0,0 +1,14 @@
+config LORAWAN
+	tristate "MAC layer of LoRaWAN Network support"
+	select CRYPTO
+	select CRYPTO_CMAC
+	select CRYPTO_CBC
+	select CRYPTO_AES
+	---help---
+	  LoRaWAN defines a low data rate, low power and long range wireless
+	  wide area networks. It was designed to organise networks of sensors,
+	  switches and actuators, etc automation devices.  It could operate as
+	  multiple kilometers wide.
+
+	  Say Y here to compile LoRaWAN support into the kernel or say M to
+	  compile it as modules.
diff --git a/net/maclorawan/Makefile b/net/maclorawan/Makefile
new file mode 100644
index 000000000000..fd7427c9ce52
--- /dev/null
+++ b/net/maclorawan/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_LORAWAN)	+= lorawan.o
+lorawan-objs		:= main.o mac.o lrwsec.o socket.o
diff --git a/net/maclorawan/lorawan.h b/net/maclorawan/lorawan.h
new file mode 100644
index 000000000000..3e49524a16fb
--- /dev/null
+++ b/net/maclorawan/lorawan.h
@@ -0,0 +1,219 @@
+/*-
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    similar to the "NO WARRANTY" disclaimer below ("Disclaimer") and any
+ *    redistribution must be conditioned upon including a substantially
+ *    similar Disclaimer requirement for further binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF NONINFRINGEMENT, MERCHANTIBILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY,
+ * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#ifndef __LORAWAN_H__
+#define __LORAWAN_H__
+
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include <linux/netdevice.h>
+#include <uapi/linux/if_arp.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include <linux/maclorawan/lora.h>
+
+#define	LORAWAN_MODULE_NAME	"lorawan"
+
+/* States of LoRaWAN slot timing */
+enum {
+	LRW_INIT_SS,
+	LRW_XMITTING_SS,
+	LRW_XMITTED,
+	LRW_RX1_SS,
+	LRW_RX2_SS,
+	LRW_RXTIMEOUT_SS,
+	LRW_RXRECEIVED_SS,
+	LRW_RETRANSMIT_SS,
+};
+
+#define	LRW_MHDR_LEN		1
+#define	LRW_FHDR_MAX_LEN	22
+#define	LRW_FOPS_MAX_LEN	15
+#define	LRW_FPORT_LEN		1
+#define	LRW_MIC_LEN		4
+
+/**
+ * lrw_fhdr - Hold the message's basic information of the frame
+ *
+ * @mtype:		this message's type
+ * @fctrl:		the frame control byte
+ * @fcnt:		this message's frame counter value
+ * @fopts:		this frame's options field
+ * @fopts_len:		the length of the fopts
+ */
+struct lrw_fhdr {
+	u8 mtype;
+	u8 fctrl;
+	u16 fcnt;
+	u8 fopts[LRW_FPORT_LEN];
+	u8 fopts_len;
+};
+
+/**
+ * lrw_session - LoRaWAN session for Class A end device
+ *
+ * @lrw_st:		points to the belonging lrw_st
+ * @entry:		the entry of the ss_list in lrw_struct
+ * @devaddr:		the LoRaWAN device address of this LoRaWAN hardware
+ * @fcnt_up:		uplink frame counter
+ * @fcnt_down:		downlink frame counter
+ * @fport:		the LoRaWAN data message's port field
+ * @tx_skb:		points to the TX skb, the frame
+ * @rx_skb:		points to the RX skb, the frame
+ * @tx_fhdr:		hold the message's basic information of the TX frame
+ * @rx_fhdr:		hold the message's basic information of the RX frame
+ * @tx_should_ack:	flag for determining the TX which should be acked or not
+ * @retry:		retry times for xmitting failed
+ * @state:		this session's current state
+ * @state_lock:		lock of the session's state
+ * @timer:		timing for this session and the state transition
+ * @timeout_work:	work if waiting acknowledge time out
+ * @rx_delay1:		RX1 delay time in seconds
+ * @rx_delay2:		RX2 delay time in seconds
+ * @rx1_window:		RX1 window opening time in mini-seconds
+ * @rx2_window:		RX2 window opening time in mini-seconds
+ * @ack_timeout:	time out time for waiting acknowledge in seconds
+ */
+struct lrw_session {
+	struct lrw_struct *lrw_st;
+	struct list_head entry;
+
+	u8 devaddr[LRW_DEVADDR_LEN];
+	u16 fcnt_up;
+	u16 fcnt_down;
+	u8 fport;
+	struct sk_buff *tx_skb;
+	struct sk_buff *rx_skb;
+	struct lrw_fhdr tx_fhdr;
+	struct lrw_fhdr rx_fhdr;
+
+	bool tx_should_ack;
+	u8 retry;
+	u8 state;
+	spinlock_t state_lock;
+
+	struct timer_list timer;
+	struct work_struct timeout_work;
+	unsigned long rx_delay1;
+	unsigned long rx_delay2;
+	unsigned long rx1_window;
+	unsigned long rx2_window;
+	unsigned long ack_timeout;
+};
+
+/**
+ * lrw_struct - The full LoRaWAN hardware to the LoRa device.
+ *
+ * @dev:		this LoRa device registed in system
+ * @lrw_hw:		the LoRa device of this LoRaWAN hardware
+ * @ops:		handle of LoRa operations interfaces
+ * @rx_skb_list:	the list of received frames
+ * @ss_list:		LoRaWAN session list of this LoRaWAN hardware
+ * @_cur_ss:		pointer of the current processing session
+ * @rx_should_ack:	represent the current session should be acked or not
+ * @state:		the state of this LoRaWAN hardware
+ * @app_eui:		the LoRaWAN application EUI
+ * @dev_eui:		the LoRaWAN device EUI
+ * @devaddr:		the LoRaWAN device address of this LoRaWAN hardware
+ * @appky:		the Application key
+ * @nwkskey:		the Network session key
+ * @appskey:		the Application session key
+ * @nwks_shash_tfm:	the hash handler for LoRaWAN network session
+ * @nwks_skc_tfm:	the crypto handler for LoRaWAN network session
+ * @apps_skc_tfm:	the crypto handler for LoRaWAN application session
+ * @fcnt_up:		the counter of this LoRaWAN hardware's up frame
+ * @fcnt_down:		the counter of this LoRaWAN hardware's down frame
+ * @xmit_task:		the xmit task for the current LoRaWAN session
+ * @rx_work:		the RX work in workqueue for the current LoRaWAN session
+ * @ndev:		points to the emulating network device
+ * @_net:		the current network namespace of this LoRaWAN hardware
+ */
+struct lrw_struct {
+	struct device dev;
+	struct lrw_hw hw;
+	struct lrw_operations *ops;
+
+	struct sk_buff_head rx_skb_list;
+	struct list_head ss_list;
+	struct mutex ss_list_lock;
+	struct lrw_session *_cur_ss;
+	bool rx_should_ack;
+	u8 state;
+
+	__le64 app_eui;
+	__le64 dev_eui;
+	__le32 devaddr;
+	u8 appkey[LRW_KEY_LEN];
+	u8 nwkskey[LRW_KEY_LEN];
+	u8 appskey[LRW_KEY_LEN];
+	struct crypto_shash *nwks_shash_tfm;
+	struct crypto_skcipher *nwks_skc_tfm;
+	struct crypto_skcipher *apps_skc_tfm;
+
+	u16 fcnt_up;
+	u16 fcnt_down;
+
+	struct tasklet_struct xmit_task;
+	struct work_struct rx_work;
+
+	struct net_device *ndev;
+	possible_net_t _net;
+};
+
+#define	NETDEV_2_LRW(ndev)	((struct lrw_struct *)netdev_priv(ndev))
+
+struct lrw_session * lrw_alloc_ss(struct lrw_struct *);
+void lrw_free_ss(struct lrw_session *);
+void lrw_del_ss(struct lrw_session *);
+int lrw_start_hw(struct lrw_struct *);
+void lrw_stop_hw(struct lrw_struct *);
+void lrw_prepare_tx_frame(struct lrw_session *);
+void lrw_xmit(unsigned long);
+void lrw_rx_work(struct work_struct *);
+
+int lrw_sock_init(void);
+void lrw_sock_exit(void);
+
+struct lrw_mac_cb {
+	int rssi;
+	u32 devaddr;
+};
+
+#endif
diff --git a/net/maclorawan/lrwsec.c b/net/maclorawan/lrwsec.c
new file mode 100644
index 000000000000..5a9ba184343d
--- /dev/null
+++ b/net/maclorawan/lrwsec.c
@@ -0,0 +1,237 @@
+/*-
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    similar to the "NO WARRANTY" disclaimer below ("Disclaimer") and any
+ *    redistribution must be conditioned upon including a substantially
+ *    similar Disclaimer requirement for further binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF NONINFRINGEMENT, MERCHANTIBILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY,
+ * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#include <linux/scatterlist.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include "lrwsec.h"
+
+struct crypto_shash *
+lrw_mic_key_setup(u8 *k, size_t k_len)
+{
+	char *algo = "cmac(aes)";
+	struct crypto_shash *tfm;
+	int err;
+
+	tfm = crypto_alloc_shash(algo, 0, 0);
+	if (!IS_ERR(tfm)) {
+		err = crypto_shash_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_shash(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+int
+lrw_aes_cmac(struct crypto_shash *tfm, u8 *bz, u8 *data, size_t len, u8 *out)
+{
+	SHASH_DESC_ON_STACK(desc, tfm);
+	int err;
+
+	desc->tfm = tfm;
+
+	err = crypto_shash_init(desc);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, bz, 16);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, data, len);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_final(desc, out);
+
+lrw_aes_cmac_end:
+	return err;
+}
+
+int
+lrw_set_bzero(u8 dir, u8 *devaddr, u32 fcnt, u8 len, u8 *bz)
+{
+	__le32 _fcnt = cpu_to_le32(fcnt);
+
+	bz[0] = 0x49;
+	memset(bz + 1, 0x00, 4);
+	bz[5] = dir;
+	memcpy(bz + 6, devaddr, 4);
+	memcpy(bz + 10, &_fcnt, 4);
+	bz[14] = 0x00;
+	bz[15] = len;
+
+	return 0;
+}
+
+int
+lrw_calc_mic(struct crypto_shash *tfm,
+	     u8 dir, u8 *devaddr, u32 fcnt, u8* buf, size_t len, u8 *mic4)
+{
+	u8 mic[16];
+	u8 bz[16];
+	int err;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.4 Massege Integrity Code (MIC) */
+	lrw_set_bzero(dir, devaddr, fcnt, len, bz);
+	err = lrw_aes_cmac(tfm, bz, buf, len, mic);
+	if (!err)
+		memcpy(mic4, mic, 4);
+
+	return err;
+}
+
+void
+lrw_mic_key_free(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
+
+struct crypto_skcipher *
+lrw_aes_enc_key_setup(char *algo, u8 *k, size_t k_len)
+{
+	struct crypto_skcipher *tfm;
+	int err;
+
+	tfm = crypto_alloc_skcipher(algo, 0, CRYPTO_ALG_ASYNC);
+	if (!IS_ERR(tfm)) {
+		err = crypto_skcipher_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_skcipher(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+struct crypto_skcipher *
+lrw_encrypt_key_setup(u8 *k, size_t k_len)
+{
+	return lrw_aes_enc_key_setup("cbc(aes)", k, k_len);
+}
+
+int
+lrw_aes_enc(struct crypto_skcipher *tfm, u8 *in, size_t len, u8 *out)
+{
+	u8 iv[16];
+	struct scatterlist src, dst;
+	SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	int err;
+
+	memset(iv, 0, 16);
+	/* The buffer for sg_init_one cannot be a global or const local
+	 * (will confuse the scatterlist) */
+	sg_init_one(&src, in, len);
+	sg_init_one(&dst, out, len);
+
+	skcipher_request_set_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, &src, &dst, len, iv);
+	err = crypto_skcipher_encrypt(req);
+	skcipher_request_zero(req);
+
+	return err;
+}
+
+#define	LRW_SEQUENCE_OF_BLOCK_LEN	16
+
+int
+lrw_set_sob(u8 dir, u8 *devaddr, u32 fcnt, u8 index, u8 *sob)
+{
+	__le32 _fcnt = cpu_to_le32(fcnt);
+
+	sob[0] = 0x01;
+	memset(sob + 1, 0x00, 4);
+	sob[5] = dir;
+	memcpy(sob + 6, devaddr, 4);
+	memcpy(sob + 10, &_fcnt, 4);
+	sob[14] = 0x00;
+	sob[15] = index;
+
+	return 0;
+}
+
+int
+lrw_encrypt_sob(struct crypto_skcipher *tfm, u8 *sob)
+{
+	return lrw_aes_enc(tfm, sob, LRW_SEQUENCE_OF_BLOCK_LEN, sob);
+}
+
+int
+lrw_encrypt_buf(struct crypto_skcipher *tfm,
+		u8 dir, u8 *devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	u8 sob[LRW_SEQUENCE_OF_BLOCK_LEN];
+	u8 i, j;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.3.3 MAC Frame Payload Encryption (FRMPayload) */
+	for (i = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN) < len; i++) {
+		lrw_set_sob(dir, devaddr, fcnt, i, sob);
+		lrw_encrypt_sob(tfm, sob);
+		for (j = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN + j) < len; j++)
+			buf[i * LRW_SEQUENCE_OF_BLOCK_LEN + j] ^= sob[j];
+	}
+
+	return 0;
+}
+
+int
+lrw_decrypt_buf(struct crypto_skcipher *tfm,
+		u8 dir, u8 *devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	/* Accoding to XOR swap algorithm */
+	return lrw_encrypt_buf(tfm, dir, devaddr, fcnt, buf, len);
+}
+
+void
+lrw_aes_enc_key_free(struct crypto_skcipher *tfm)
+{
+	crypto_free_skcipher(tfm);
+}
+
+void
+lrw_encrypt_key_free(struct crypto_skcipher *tfm)
+{
+	lrw_aes_enc_key_free(tfm);
+}
diff --git a/net/maclorawan/lrwsec.h b/net/maclorawan/lrwsec.h
new file mode 100644
index 000000000000..cd8a2d71b0f2
--- /dev/null
+++ b/net/maclorawan/lrwsec.h
@@ -0,0 +1,57 @@
+/*-
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    similar to the "NO WARRANTY" disclaimer below ("Disclaimer") and any
+ *    redistribution must be conditioned upon including a substantially
+ *    similar Disclaimer requirement for further binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF NONINFRINGEMENT, MERCHANTIBILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY,
+ * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#ifndef __LORA_CRYPTO_H__
+#define __LORA_CRYPTO_H__
+
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+
+struct crypto_shash *lrw_mic_key_setup(u8 *k, size_t k_len);
+int lrw_calc_mic(struct crypto_shash *tfm,
+		 u8 dir, u8 *devaddr, u32 fcnt, u8* buf, size_t len, u8 *mic4);
+void lrw_mic_key_free(struct crypto_shash *tfm);
+
+struct crypto_skcipher *lrw_encrypt_key_setup(u8 *k, size_t k_len);
+int lrw_encrypt_buf(struct crypto_skcipher *tfm,
+		    u8 dir, u8 *devaddr, u32 fcnt, u8 *buf, size_t len);
+int lrw_decrypt_buf(struct crypto_skcipher *tfm,
+		    u8 dir, u8 *devaddr, u32 fcnt, u8 *buf, size_t len);
+void lrw_encrypt_key_free(struct crypto_skcipher *tfm);
+
+#endif
diff --git a/net/maclorawan/mac.c b/net/maclorawan/mac.c
new file mode 100644
index 000000000000..a6b75749d05c
--- /dev/null
+++ b/net/maclorawan/mac.c
@@ -0,0 +1,552 @@
+/*-
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    similar to the "NO WARRANTY" disclaimer below ("Disclaimer") and any
+ *    redistribution must be conditioned upon including a substantially
+ *    similar Disclaimer requirement for further binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF NONINFRINGEMENT, MERCHANTIBILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY,
+ * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/poll.h>
+#include <asm/uaccess.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+
+#include <linux/maclorawan/lora.h>
+#include "lorawan.h"
+#include "lrwsec.h"
+
+static void rx_timeout_work(struct work_struct *work);
+
+struct lrw_session *
+lrw_alloc_ss(struct lrw_struct *lrw_st)
+{
+	struct lrw_session *ss;
+
+	ss = kzalloc(sizeof(struct lrw_session), GFP_KERNEL);
+	if (!ss)
+		goto lrw_alloc_ss_end;
+
+	ss->lrw_st = lrw_st;
+	memcpy(ss->devaddr, &lrw_st->devaddr, LRW_DEVADDR_LEN);
+	INIT_LIST_HEAD(&ss->entry);
+
+	ss->tx_should_ack = false;
+	ss->retry = 3;
+	spin_lock_init(&ss->state_lock);
+	INIT_WORK(&ss->timeout_work, rx_timeout_work);
+
+lrw_alloc_ss_end:
+	return ss;
+}
+
+void
+lrw_free_ss(struct lrw_session *ss)
+{
+	netdev_dbg(ss->lrw_st->ndev, "%s\n", __func__);
+	if (ss->tx_skb)
+		consume_skb(ss->tx_skb);
+	netdev_dbg(ss->lrw_st->ndev, "%s: free rx skb\n", __func__);
+	if (ss->rx_skb)
+		consume_skb(ss->rx_skb);
+
+	netdev_dbg(ss->lrw_st->ndev, "%s: free ss\n", __func__);
+	kfree(ss);
+}
+
+void
+lrw_del_ss(struct lrw_session *ss)
+{
+	netdev_dbg(ss->lrw_st->ndev, "%s\n", __func__);
+	list_del(&ss->entry);
+	lrw_free_ss(ss);
+}
+
+void
+lrw_del_all_ss(struct lrw_struct *lrw_st)
+{
+	struct lrw_session *ss, *tmp;
+
+	mutex_lock(&lrw_st->ss_list_lock);
+	lrw_st->_cur_ss = NULL;
+	list_for_each_entry_safe(ss, tmp, &lrw_st->ss_list, entry) {
+		del_timer(&ss->timer);
+		lrw_del_ss(ss);
+	}
+	mutex_unlock(&lrw_st->ss_list_lock);
+}
+
+void
+lrw_ready_hw(struct lrw_struct *lrw_st)
+{
+	lrw_st->state = LRW_STATE_IDLE;
+}
+
+int
+lrw_start_hw(struct lrw_struct *lrw_st)
+{
+	int ret = 0;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+	lrw_st->nwks_shash_tfm = lrw_mic_key_setup(lrw_st->nwkskey,
+						   LRW_KEY_LEN);
+	lrw_st->nwks_skc_tfm = lrw_encrypt_key_setup(lrw_st->nwkskey,
+						     LRW_KEY_LEN);
+	lrw_st->apps_skc_tfm = lrw_encrypt_key_setup(lrw_st->appskey,
+						     LRW_KEY_LEN);
+	lrw_st->state = LRW_START;
+	ret = lrw_st->ops->start(&lrw_st->hw);
+	if (!ret)
+		lrw_ready_hw(lrw_st);
+
+	return ret;
+}
+
+void
+lrw_stop_hw(struct lrw_struct *lrw_st)
+{
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+	lrw_st->state = LRW_STOP;
+	netdev_dbg(lrw_st->ndev, "%s: going to stop hardware\n", __func__);
+	lrw_st->ops->stop(&lrw_st->hw);
+
+	netdev_dbg(lrw_st->ndev, "%s: going to kill tasks & flush works", __func__);
+	tasklet_kill(&lrw_st->xmit_task);
+	flush_work(&lrw_st->rx_work);
+
+	netdev_dbg(lrw_st->ndev, "%s: going to delete all session\n", __func__);
+	lrw_del_all_ss(lrw_st);
+
+	netdev_dbg(lrw_st->ndev, "%s: going to free mic tfm\n", __func__);
+	lrw_mic_key_free(lrw_st->nwks_shash_tfm);
+	netdev_dbg(lrw_st->ndev, "%s: going to free nwks tfm\n", __func__);
+	lrw_encrypt_key_free(lrw_st->nwks_skc_tfm);
+	netdev_dbg(lrw_st->ndev, "%s: going to free apps tfm\n", __func__);
+	lrw_encrypt_key_free(lrw_st->apps_skc_tfm);
+}
+
+void
+lrw_prepare_tx_frame(struct lrw_session *ss)
+{
+	struct lrw_struct *lrw_st = ss->lrw_st;
+	struct sk_buff *skb = ss->tx_skb;
+	u8 mhdr, fctrl, fport;
+	u8 mic[4];
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	mhdr = LRW_UNCONFIRMED_DATA_UP << 5;
+	if ((mhdr & (0x6 << 5)) == (0x4 << 5))
+		ss->tx_should_ack = true;
+
+	fctrl = 0;
+	if (lrw_st->rx_should_ack) {
+		fctrl |= 0x20;
+		lrw_st->rx_should_ack = false;
+	}
+
+	/* Encrypt the plain buffer content */
+	lrw_encrypt_buf(lrw_st->apps_skc_tfm, LRW_UPLINK,
+			ss->devaddr, ss->fcnt_up, skb->data, skb->len);
+
+	/* Push FPort */
+	if (skb->len) {
+		fport = ss->fport;
+		memcpy(skb_push(skb, LRW_FPORT_LEN), &fport, LRW_FPORT_LEN);
+	}
+
+	/* Push FCnt_Up */
+	memcpy(skb_push(skb, 2), &ss->fcnt_up, 2);
+
+	/* Push FCtrl */
+	memcpy(skb_push(skb, 1), &fctrl, 1);
+
+	/* Push DevAddr */
+	memcpy(skb_push(skb, LRW_DEVADDR_LEN), ss->devaddr, LRW_DEVADDR_LEN);
+
+	/* Push MHDR */
+	memcpy(skb_push(skb, LRW_MHDR_LEN), &mhdr, LRW_MHDR_LEN);
+
+	/* Put MIC */
+	lrw_calc_mic(lrw_st->nwks_shash_tfm, LRW_UPLINK,
+		     ss->devaddr, ss->fcnt_up, skb->data, skb->len, mic);
+	memcpy(skb_put(skb, LRW_MIC_LEN), mic, LRW_MIC_LEN);
+}
+
+void
+lrw_xmit(unsigned long data)
+{
+	struct lrw_struct *lrw_st = (struct lrw_struct *) data;
+	struct lrw_session *ss = lrw_st->_cur_ss;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+	ss->state = LRW_XMITTING_SS;
+	lrw_st->ops->xmit_async(&lrw_st->hw, ss->tx_skb);
+}
+
+void
+lrw_parse_frame(struct lrw_session *ss, struct sk_buff *skb)
+{
+	struct lrw_fhdr *fhdr = &ss->rx_fhdr;
+	__le16 *p_fcnt;
+
+	pr_debug("%s: %s\n", LORAWAN_MODULE_NAME, __func__);
+
+	/* Get message type */
+	fhdr->mtype = skb->data[0];
+	skb_pull(skb, LRW_MHDR_LEN);
+
+	/* Trim Device Address */
+	skb_pull(skb, 4);
+
+	/* Get frame control */
+	fhdr->fctrl = skb->data[0];
+	skb_pull(skb, 1);
+
+	/* Ack the original TX frame if it should be acked */
+	if (ss->tx_should_ack && (fhdr->fctrl & 0x20))
+		ss->tx_should_ack = false;
+
+	/* Get frame count */
+	p_fcnt = (__le16 *)skb->data;
+	fhdr->fcnt = le16_to_cpu(*p_fcnt);
+	skb_pull(skb, 2);
+
+	/* Get frame options */
+	fhdr->fopts_len = fhdr->fctrl & 0xF;
+	if (fhdr->fopts_len > 0) {
+		memcpy(fhdr->fopts, skb->data, fhdr->fopts_len);
+		skb_pull(skb, fhdr->fopts_len);
+	}
+
+	/* TODO: Parse frame options */
+
+	/* Remove message integrity code */
+	skb_trim(skb, skb->len - LRW_MIC_LEN);
+}
+
+struct lrw_session *
+lrw_rx_skb_2_session(struct lrw_struct *lrw_st, struct sk_buff *rx_skb)
+{
+	struct lrw_session *ss;
+	u16 fcnt;
+	__le16 *p_fcnt;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	p_fcnt = (__le16 *)(rx_skb->data + 6);
+	fcnt = le16_to_cpu(*p_fcnt);
+
+	/* Find the corresponding session */
+	ss = lrw_st->_cur_ss;
+
+	/* Frame count downlink check */
+	if (fcnt >= (ss->fcnt_down & 0xFFFF))
+		ss->rx_skb = rx_skb;
+	else
+		ss = NULL;
+
+	return ss;
+}
+
+void
+lrw_rx_work(struct work_struct *work)
+{
+	struct lrw_struct *lrw_st;
+	struct lrw_session *ss;
+	struct sk_buff *skb;
+
+	lrw_st = container_of(work, struct lrw_struct, rx_work);
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	skb = lrw_st->rx_skb_list.next;
+	skb_dequeue(&lrw_st->rx_skb_list);
+
+	/* Check and parse the RX frame */
+	ss = lrw_rx_skb_2_session(lrw_st, skb);
+	if (!ss)
+		goto lrw_rx_work_not_new_frame;
+
+	lrw_parse_frame(ss, skb);
+
+	/* Check the TX frame is acked or not */
+	if (ss->tx_should_ack) {
+		ss->rx_skb = NULL;
+		goto lrw_rx_work_not_new_frame;
+	}
+
+	/* The TX frame is acked or no need to be acked */
+	del_timer(&ss->timer);
+	lrw_st->rx_should_ack = (ss->rx_fhdr.mtype & 0xC0) == 0x40;
+
+	lrw_st->ndev->stats.rx_packets++;
+	lrw_st->ndev->stats.rx_bytes += ss->rx_skb->len;
+
+	if (ss->rx_skb->len > 0) {
+		spin_lock_bh(&ss->state_lock);
+		ss->state = LRW_RXRECEIVED_SS;
+		spin_unlock_bh(&ss->state_lock);
+
+		netif_receive_skb(skb);
+
+		ss->rx_skb = NULL;
+	}
+
+	mutex_lock(&lrw_st->ss_list_lock);
+	lrw_st->fcnt_down = ss->rx_fhdr.fcnt;
+	lrw_st->_cur_ss = NULL;
+	lrw_del_ss(ss);
+	lrw_st->state = LRW_STATE_IDLE;
+	mutex_unlock(&lrw_st->ss_list_lock);
+
+	return;
+
+lrw_rx_work_not_new_frame:
+	/* Drop the RX frame if checked failed */
+	kfree_skb(skb);
+}
+
+int
+lrw_check_mic(struct crypto_shash *tfm, struct sk_buff *skb)
+{
+	u8 *buf;
+	size_t len;
+	u8 *devaddr;
+	u16 fcnt;
+	__le16 *p_fcnt;
+	u8 cks[4];
+	u8 *mic;
+
+	buf = skb->data;
+	len = skb->len - 4;
+	devaddr = buf + 1;
+	p_fcnt = (__le16 *)(buf + 6);
+	fcnt = le16_to_cpu(*p_fcnt);
+	mic = skb->data + len;
+
+	lrw_calc_mic(tfm, LRW_DOWNLINK, devaddr, fcnt, buf, len, cks);
+
+	return (!memcmp(cks, mic, 4));
+}
+
+/**
+ * lrw_rx_irqsave - Tell LoRaWAN module that there is new received frame
+ * @hw:		the LoRa device
+ * @skb:	the new received frame
+ */
+void
+lrw_rx_irqsave(struct lrw_hw *hw, struct sk_buff *skb)
+{
+	struct lrw_struct *lrw_st = container_of(hw, struct lrw_struct, hw);
+	u8 mtype;
+	bool is_new_frame;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	mtype = skb->data[0] >> 5;
+	is_new_frame = 0;
+
+	/* Check the frame is downlink frame */
+	if (((mtype == LRW_UNCONFIRMED_DATA_DOWN)
+	      || (mtype == LRW_CONFIRMED_DATA_DOWN))
+	    && (memcmp(&lrw_st->devaddr, skb->data + LRW_MHDR_LEN, 4) != 0)
+	    && lrw_check_mic(lrw_st->nwks_shash_tfm, skb))
+		is_new_frame = true;
+
+	if (is_new_frame) {
+		skb_queue_tail(&lrw_st->rx_skb_list, skb);
+		schedule_work(&lrw_st->rx_work);
+	}
+	else {
+		kfree_skb(skb);
+	}
+}
+EXPORT_SYMBOL(lrw_rx_irqsave);
+
+static void
+lrw_rexmit(struct timer_list *timer)
+{
+	struct lrw_session *ss = container_of(timer, struct lrw_session, timer);
+	struct lrw_struct *lrw_st = ss->lrw_st;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	lrw_st->state = LRW_STATE_TX;
+	lrw_xmit((unsigned long) lrw_st);
+}
+
+static void
+rx_timeout_work(struct work_struct *work)
+{
+	struct lrw_session *ss;
+	struct lrw_struct *lrw_st;
+
+	ss = container_of(work, struct lrw_session, timeout_work);
+	lrw_st = ss->lrw_st;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+	mutex_lock(&lrw_st->ss_list_lock);
+	lrw_st->_cur_ss = NULL;
+	lrw_st->state = LRW_STATE_IDLE;
+	lrw_del_ss(ss);
+	mutex_unlock(&lrw_st->ss_list_lock);
+}
+
+static void
+rx2_timeout_isr(struct timer_list *timer)
+{
+	struct lrw_session *ss = container_of(timer, struct lrw_session, timer);
+	struct lrw_struct *lrw_st = ss->lrw_st;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	/* Check TX is acked or not */
+	if (!ss->tx_should_ack) {
+		spin_lock_bh(&ss->state_lock);
+		if (ss->state != LRW_RXRECEIVED_SS)
+			ss->state = LRW_RXTIMEOUT_SS;
+		spin_unlock_bh(&ss->state_lock);
+
+		if (ss->state == LRW_RXTIMEOUT_SS) {
+			netdev_dbg(lrw_st->ndev, "%s: rx time out\n", __func__);
+			goto rx2_timeout_isr_no_retry_rx_frame;
+		}
+		else {
+			return;
+		}
+	}
+
+	/* Check the session need to be retransmitted or not */
+	if (ss->retry > 0) {
+		ss->state = LRW_RETRANSMIT_SS;
+		ss->retry--;
+
+		/* Start timer for ack timeout and retransmit */
+		ss->timer.function = lrw_rexmit;
+		ss->timer.expires = jiffies_64 + ss->ack_timeout * HZ;
+		add_timer(&ss->timer);
+	}
+	else {
+		/* Retry failed */
+rx2_timeout_isr_no_retry_rx_frame:
+		schedule_work(&ss->timeout_work);
+	}
+}
+
+static void
+rx2_delay_isr(struct timer_list *timer)
+{
+	struct lrw_session *ss = container_of(timer, struct lrw_session, timer);
+	struct lrw_struct *lrw_st = ss->lrw_st;
+	unsigned long delay;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	/* Start timer for RX2 window */
+	ss->timer.function = rx2_timeout_isr;
+	delay = jiffies_64 + (ss->rx2_window + 20) * HZ / 1000 + HZ;
+	ss->timer.expires = delay;
+	add_timer(&ss->timer);
+
+	/* Start LoRa hardware to RX2 window */
+	ss->state = LRW_RX2_SS;
+	lrw_st->ops->start_rx_window(&lrw_st->hw, ss->rx2_window + 20);
+}
+
+static void
+rx1_delay_isr(struct timer_list *timer)
+{
+	struct lrw_session *ss = container_of(timer, struct lrw_session, timer);
+	struct lrw_struct *lrw_st = ss->lrw_st;
+	unsigned long delay;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	/* Start timer for RX_Delay2 - RX_Delay2 */
+	ss->timer.function = rx2_delay_isr;
+	delay = jiffies_64 + (ss->rx_delay2 - ss->rx_delay1) * HZ - 20 * HZ / 1000;
+	ss->timer.expires = delay;
+	add_timer(&ss->timer);
+
+	/* Start LoRa hardware to RX1 window */
+	ss->state = LRW_RX1_SS;
+	lrw_st->ops->start_rx_window(&lrw_st->hw, ss->rx1_window + 20);
+}
+
+void
+lrw_sent_tx_work(struct lrw_struct *lrw_st, struct sk_buff *skb)
+{
+	struct lrw_session *ss = lrw_st->_cur_ss;
+	struct net_device *ndev;
+	unsigned long delay;
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	ss->state = LRW_XMITTED;
+
+	/* Start session timer for RX_Delay1 */
+	timer_setup(&ss->timer, rx1_delay_isr, 0);
+	delay = jiffies_64 + ss->rx_delay1 * HZ - 20 * HZ / 1000;
+	ss->timer.expires = delay;
+	add_timer(&ss->timer);
+
+	ndev = skb->dev;
+	ndev->stats.tx_packets++;
+	ndev->stats.tx_bytes += skb->len;
+	dev_consume_skb_any(skb);
+	ss->tx_skb = NULL;
+}
+
+/**
+ * lrw_xmit_complete - Tell LoRaWAN module that the frame is xmitted completely
+ * @hw:		the LoRa device
+ * @skb:	the xmitted frame
+ */
+void
+lrw_xmit_complete(struct lrw_hw *hw, struct sk_buff *skb)
+{
+	struct lrw_struct *lrw_st = container_of(hw, struct lrw_struct, hw);
+
+	netdev_dbg(lrw_st->ndev, "%s\n", __func__);
+
+	lrw_sent_tx_work(lrw_st, skb);
+	lrw_st->state = LRW_STATE_RX;
+}
+EXPORT_SYMBOL(lrw_xmit_complete);
diff --git a/net/maclorawan/main.c b/net/maclorawan/main.c
new file mode 100644
index 000000000000..4fcb5a442686
--- /dev/null
+++ b/net/maclorawan/main.c
@@ -0,0 +1,665 @@
+/*-
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    similar to the "NO WARRANTY" disclaimer below ("Disclaimer") and any
+ *    redistribution must be conditioned upon including a substantially
+ *    similar Disclaimer requirement for further binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF NONINFRINGEMENT, MERCHANTIBILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY,
+ * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <net/rtnetlink.h>
+
+#include <linux/maclorawan/lora.h>
+#include "lorawan.h"
+
+#define	PHY_NAME		"lora"
+
+static struct class *lrw_sys_class;
+
+static void
+lrw_if_setup(struct net_device *ndev)
+{
+	ndev->addr_len = LRW_DEVADDR_LEN;
+	memset(ndev->broadcast, 0xFF, ndev->addr_len);
+	ndev->type = ARPHRD_LORAWAN;
+
+	ndev->hard_header_len = LRW_MHDR_LEN + LRW_FHDR_MAX_LEN + LRW_FPORT_LEN;
+	ndev->needed_tailroom = LRW_MIC_LEN;
+
+	/**
+	 * TODO: M should be a dynamic value defined by Regional Parameters,
+	 * 	 Being fixed for now.  Going to be changed.
+	 */
+	ndev->mtu = 20;
+}
+
+/**
+ * lrw_alloc_hw - Allocate a memory space for the LoRa device
+ * @priv_data_len:	the private data size
+ * @lrw_operations:	the implemented operations of the LoRa device
+ *
+ * Return:		address of the LoRa device or NULL for failed
+ */
+struct lrw_hw *
+lrw_alloc_hw(size_t priv_data_len, struct lrw_operations *ops)
+{
+	struct net_device *ndev;
+	struct lrw_struct *lrw_st;
+	int ret;
+
+	if (WARN_ON(!ops || !ops->start || !ops->stop || !ops->xmit_async ||
+		    !ops->set_txpower || !ops->set_frq || !ops->set_bw ||
+		    !ops->set_mod || !ops->set_sf || !ops->start_rx_window ||
+		    !ops->set_state))
+		return NULL;
+
+	/* In memory it'll be like this:
+	 *
+	 * +-----------------------+
+	 * | struct net_device     |
+	 * +-----------------------+
+	 * | struct lrw_struct     |
+	 * +-----------------------+
+	 * | driver's private data |
+	 * +-----------------------+
+	 */
+	ndev = alloc_netdev(sizeof(struct lrw_struct) + priv_data_len,
+			    PHY_NAME"%d", NET_NAME_ENUM, lrw_if_setup);
+	if (!ndev)
+		return ERR_PTR(-ENOMEM);
+	ret = dev_alloc_name(ndev, ndev->name);
+	if (ret < 0)
+		goto lrw_alloc_hw_err;
+
+	lrw_st = (struct lrw_struct *)netdev_priv(ndev);
+	lrw_st->ndev = ndev;
+
+	lrw_st->state = LRW_STOP;
+	lrw_st->ops = ops;
+	lrw_st->hw.priv = (void *) lrw_st + sizeof(struct lrw_struct);
+
+	ndev->flags |= IFF_NOARP;
+	ndev->features |= NETIF_F_HW_CSUM;
+
+	return &lrw_st->hw;
+
+lrw_alloc_hw_err:
+	free_netdev(ndev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(lrw_alloc_hw);
+
+/**
+ * lrw_free_hw - Free the LoRa device's memory resource
+ * @hw:		the LoRa device going to be freed
+ */
+void
+lrw_free_hw(struct lrw_hw *hw)
+{
+	struct lrw_struct *lrw_st;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+	free_netdev(lrw_st->ndev);
+}
+EXPORT_SYMBOL(lrw_free_hw);
+
+/**
+ * lrw_set_deveui - Set the LoRa device's DevEUI
+ * @hw:		the LoRa device going to be set
+ * @eui:	the global end-device ID in IEEE EUI64 address space
+ */
+void
+lrw_set_deveui(struct lrw_hw *hw, __le64 eui)
+{
+	struct lrw_struct *lrw_st;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+	lrw_st->dev_eui = eui;
+}
+EXPORT_SYMBOL(lrw_set_deveui);
+
+/**
+ * lrw_get_deveui - Get the LoRa device's DevEUI
+ * @hw:		the LoRa device going to be got from
+ *
+ * Return:	the device's DevEUI in IEEE EUI64 address space
+ */
+__le64
+lrw_get_deveui(struct lrw_hw *hw)
+{
+	struct lrw_struct *lrw_st;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+	return lrw_st->dev_eui;
+}
+EXPORT_SYMBOL(lrw_get_deveui);
+
+/**
+ * lrw_set_appeui - Set the LoRa device's AppEUI
+ * @hw:		the LoRa device going to be set
+ * @eui:	the global end-device ID in IEEE EUI64 address space
+ */
+void
+lrw_set_appeui(struct lrw_hw *hw, __le64 eui)
+{
+	struct lrw_struct *lrw_st;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+	lrw_st->app_eui = eui;
+}
+EXPORT_SYMBOL(lrw_set_appeui);
+
+/**
+ * lrw_get_appeui - Get the LoRa device's AppEUI
+ * @hw:		the LoRa device going to be got from
+ *
+ * Return:	the device's AppEUI in IEEE EUI64 address space
+ */
+__le64
+lrw_get_appeui(struct lrw_hw *hw)
+{
+	struct lrw_struct *lrw_st;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+	return lrw_st->app_eui;
+}
+EXPORT_SYMBOL(lrw_get_appeui);
+
+/**
+ * lrw_set_devaddr - Set the LoRa device's address
+ * @hw:		the LoRa device going to be set
+ * @devaddr:	the device address
+ */
+void
+lrw_set_devaddr(struct lrw_hw *hw, __le32 devaddr)
+{
+	struct lrw_struct *lrw_st;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+	lrw_st->devaddr = devaddr;
+}
+EXPORT_SYMBOL(lrw_set_devaddr);
+
+/**
+ * lrw_get_devaddr - Get the LoRa device's address
+ * @hw:		the LoRa device going to be got from
+ *
+ * Return:	the device address
+ */
+__le32
+lrw_get_devaddr(struct lrw_hw *hw)
+{
+	struct lrw_struct *lrw_st;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+	return lrw_st->devaddr;
+}
+EXPORT_SYMBOL(lrw_get_devaddr);
+
+/**
+ * lrw_add_hw - Add a LoRaWAN hardware as a network device
+ * @lrw_st:	the LoRa device going to be added
+ *
+ * Return:	0 / other number for success / failed
+ */
+int
+lrw_add_hw(struct lrw_struct *lrw_st)
+{
+	struct net_device *ndev = lrw_st->ndev;
+	__be32 be_addr;
+	int ret;
+
+	lrw_st->fcnt_up = 0;
+	lrw_st->fcnt_down = 0;
+	lrw_st->_cur_ss = NULL;
+
+	mutex_init(&lrw_st->ss_list_lock);
+	INIT_LIST_HEAD(&lrw_st->ss_list);
+
+	tasklet_init(&lrw_st->xmit_task, lrw_xmit, (unsigned long) lrw_st);
+	INIT_WORK(&lrw_st->rx_work, lrw_rx_work);
+
+	be_addr = le32_to_be32(lrw_st->devaddr);
+	memcpy(ndev->perm_addr, &be_addr, ndev->addr_len);
+	memcpy(ndev->dev_addr, ndev->perm_addr, ndev->addr_len);
+
+	write_pnet(&lrw_st->_net, &init_net);
+	ret = register_netdev(ndev);
+
+	return ret;
+}
+
+/**
+ * lrw_remove_hw - Remove a LoRaWAN hardware from a network device
+ * @lrw_st:	the LoRa device going to be removed
+ */
+void
+lrw_remove_hw(struct lrw_struct *lrw_st)
+{
+	unregister_netdev(lrw_st->ndev);
+	tasklet_kill(&lrw_st->xmit_task);
+}
+
+int
+lrw_set_hw_state(struct lrw_struct *lrw_st, void __user *arg)
+{
+	int ret = 0;
+	u8 state;
+
+	ret = copy_from_user(&state, arg, 1);
+	if (ret) {
+		ret = -EACCES;
+		goto lrw_set_hw_state_end;
+	}
+
+	switch (state) {
+	case LRW_START:
+		if (lrw_st->state == LRW_STOP)
+			lrw_start_hw(lrw_st);
+		break;
+	case LRW_STOP:
+		if (lrw_st->state != LRW_STOP)
+			lrw_stop_hw(lrw_st);
+		break;
+	default:
+		ret = -ENOTSUPP;
+	}
+
+lrw_set_hw_state_end:
+	return ret;
+}
+
+bool
+ready2write(struct lrw_struct *lrw_st)
+{
+	bool status = false;
+
+	if ((!lrw_st->_cur_ss) && (lrw_st->state == LRW_STATE_IDLE))
+		status = true;
+
+	return status;
+}
+
+bool
+ready2read(struct lrw_struct *lrw_st)
+{
+	bool status = false;
+	struct lrw_session *ss;
+
+	if (!list_empty(&lrw_st->ss_list) && (lrw_st->state != LRW_STOP)) {
+		ss = list_first_entry(&lrw_st->ss_list,
+				      struct lrw_session,
+				      entry);
+		if (ss->state == LRW_RXRECEIVED_SS)
+			status = true;
+	}
+
+	return status;
+}
+
+static int
+lrw_if_up(struct net_device *ndev)
+{
+	struct lrw_struct *lrw_st = NETDEV_2_LRW(ndev);
+	int ret = -EBUSY;
+
+	if (lrw_st->state == LRW_STOP) {
+		ret = lrw_start_hw(lrw_st);
+		netif_start_queue(ndev);
+	}
+
+	return ret;
+}
+
+static int
+lrw_if_down(struct net_device *ndev)
+{
+	struct lrw_struct *lrw_st = NETDEV_2_LRW(ndev);
+
+	if (lrw_st->state != LRW_STOP) {
+		netif_stop_queue(ndev);
+		lrw_stop_hw(lrw_st);
+	}
+
+	return 0;
+}
+
+netdev_tx_t
+lrw_if_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct lrw_struct *lrw_st = NETDEV_2_LRW(ndev);
+	struct lrw_session *ss;
+	netdev_tx_t ret = NETDEV_TX_OK;
+
+	ss = lrw_alloc_ss(lrw_st);
+	if (!ss)
+		return NETDEV_TX_BUSY;
+
+	mutex_lock(&lrw_st->ss_list_lock);
+	if (ready2write(lrw_st)) {
+		list_add_tail(&ss->entry, &lrw_st->ss_list);
+		lrw_st->state = LRW_STATE_TX;
+		lrw_st->_cur_ss = ss;
+		ss->fcnt_up = lrw_st->fcnt_up;
+		ss->fcnt_down = lrw_st->fcnt_down;
+		/* TODO: RX delay #1/#2 should be set by regional parameters */
+		ss->rx_delay1 = 1;
+		ss->rx_delay2 = 2;
+		ss->rx1_window = 500;
+		ss->rx2_window = 500;
+	}
+	else
+		ret = NETDEV_TX_BUSY;
+	mutex_unlock(&lrw_st->ss_list_lock);
+
+	if (ret == NETDEV_TX_OK) {
+		ss->state = LRW_INIT_SS;
+		ss->tx_skb = skb;
+		lrw_prepare_tx_frame(ss);
+		tasklet_schedule(&lrw_st->xmit_task);
+	}
+	else
+		lrw_free_ss(ss);
+
+	return ret;
+}
+
+inline int
+lrw_if_get_addr(struct lrw_struct *lrw_st, struct sockaddr_lorawan *addr)
+{
+	int ret = 0;
+
+	switch (addr->addr_in.addr_type) {
+	case LRW_ADDR_DEVADDR:
+		addr->addr_in.devaddr = le32_to_cpu(lrw_st->devaddr);
+		break;
+	case LRW_ADDR_DEVEUI:
+		addr->addr_in.dev_eui = le64_to_cpu(lrw_st->dev_eui);
+		break;
+	case LRW_ADDR_APPEUI:
+		addr->addr_in.app_eui = le64_to_cpu(lrw_st->app_eui);
+		break;
+	default:
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+
+inline int
+lrw_if_set_addr(struct lrw_struct *lrw_st, struct sockaddr_lorawan *addr)
+{
+	struct lrw_hw *hw = &lrw_st->hw;
+	int ret = 0;
+
+	if (netif_running(lrw_st->ndev))
+		return -EBUSY;
+
+	switch (addr->addr_in.addr_type) {
+	case LRW_ADDR_DEVADDR:
+		lrw_set_devaddr(hw, cpu_to_le32(addr->addr_in.devaddr));
+		break;
+	case LRW_ADDR_DEVEUI:
+		lrw_set_deveui(hw, cpu_to_le32(addr->addr_in.dev_eui));
+		break;
+	case LRW_ADDR_APPEUI:
+		lrw_set_appeui(hw, cpu_to_le32(addr->addr_in.app_eui));
+		break;
+	default:
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+
+inline void
+swap_bytes(u8 *dst, u8 *src, size_t l)
+{
+	/* Human reading is big-endian, but LoRaWAN is little-endian */
+	unsigned int i;
+	for (i = 0; i < l; i++)
+		dst[i] = src[l - i - 1];
+}
+
+int
+lrw_set_key(struct lrw_hw *hw, u8 type, u8 *key, size_t key_len)
+{
+	struct lrw_struct *lrw_st;
+	int ret = 0;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+
+	netdev_dbg(lrw_st->ndev, "%s: type=%d\n", __func__, type);
+	if (lrw_st->state != LRW_STOP)
+		return -EINVAL;
+
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 1, key, key_len, true);
+	switch (type) {
+	case LRW_APPKEY:
+		swap_bytes(lrw_st->appkey, key, key_len);
+		break;
+	case LRW_NWKSKEY:
+		swap_bytes(lrw_st->nwkskey, key, key_len);
+		break;
+	case LRW_APPSKEY:
+		swap_bytes(lrw_st->appskey, key, key_len);
+		break;
+	default:
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(lrw_set_key);
+
+int
+lrw_get_key(struct lrw_hw *hw, u8 type, u8 *key, size_t key_len)
+{
+	struct lrw_struct *lrw_st;
+	int ret = 0;
+
+	lrw_st = container_of(hw, struct lrw_struct, hw);
+
+	netdev_dbg(lrw_st->ndev, "%s: type=%d\n", __func__, type);
+	switch (type) {
+	case LRW_APPKEY:
+		swap_bytes(key, lrw_st->appkey, key_len);
+		break;
+	case LRW_NWKSKEY:
+		swap_bytes(key, lrw_st->nwkskey, key_len);
+		break;
+	case LRW_APPSKEY:
+		swap_bytes(key, lrw_st->appskey, key_len);
+		break;
+	default:
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+
+static int
+lrw_if_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
+{
+	struct lrw_struct *lrw_st = NETDEV_2_LRW(ndev);
+	struct sockaddr_lorawan *addr;
+	int ret = 0;
+
+	netdev_dbg(ndev, "%s: ioctl file (cmd=0x%X)\n", __func__, cmd);
+
+	/* I/O control by each command */
+	switch (cmd) {
+	/* Set & get the DevAddr, DevEUI and AppEUI */
+	case SIOCSIFADDR:
+		addr = (struct sockaddr_lorawan *)&ifr->ifr_addr;
+		ret = lrw_if_set_addr(lrw_st, addr);
+		break;
+	case SIOCGIFADDR:
+		addr = (struct sockaddr_lorawan *)&ifr->ifr_addr;
+		ret = lrw_if_get_addr(lrw_st, addr);
+		break;
+	default:
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+
+static int
+lrw_if_set_mac(struct net_device *ndev, void *p)
+{
+	struct lrw_struct *lrw_st = NETDEV_2_LRW(ndev);
+	struct sockaddr *addr = p;
+	__be32 *be_addr = (__be32 *)addr->sa_data;
+
+	netdev_dbg(ndev, "%s: AF_TYPE:%d set mac address %X\n",
+		   __func__, addr->sa_family, be32_to_cpu(*be_addr));
+
+	if (netif_running(ndev))
+		return -EBUSY;
+
+	lrw_set_devaddr(&lrw_st->hw, be32_to_le32(*be_addr));
+	memcpy(ndev->dev_addr, be_addr, ndev->addr_len);
+
+	return 0;
+}
+
+static const struct net_device_ops lrw_if_ops = {
+	.ndo_open = lrw_if_up,
+	.ndo_stop = lrw_if_down,
+	.ndo_start_xmit = lrw_if_start_xmit,
+	.ndo_do_ioctl = lrw_if_ioctl,
+	.ndo_set_mac_address = lrw_if_set_mac,
+};
+
+/**
+ * lrw_register_hw - Register as a LoRaWAN compatible device
+ * @hw:		LoRa device going to be registered
+ *
+ * Return:	0 / negative number for success / error number
+ */
+int
+lrw_register_hw(struct lrw_hw *hw)
+{
+	struct lrw_struct *lrw_st = container_of(hw, struct lrw_struct, hw);
+	int ret;
+
+	device_initialize(&lrw_st->dev);
+	dev_set_name(&lrw_st->dev, netdev_name(lrw_st->ndev));
+	lrw_st->dev.class = lrw_sys_class;
+	lrw_st->dev.platform_data = lrw_st;
+
+	ret = device_add(&lrw_st->dev);
+	if (ret)
+		goto lrw_register_hw_end;
+
+	/* Add a LoRa device node as a network device */
+	lrw_st->ndev->netdev_ops = &lrw_if_ops;
+	ret = lrw_add_hw(lrw_st);
+
+lrw_register_hw_end:
+	return ret;
+}
+EXPORT_SYMBOL(lrw_register_hw);
+
+/**
+ * lrw_unregister_hw - Unregister the LoRaWAN compatible device
+ * @hw:		LoRa device going to be unregistered
+ */
+void
+lrw_unregister_hw(struct lrw_hw *hw)
+{
+	struct lrw_struct *lrw_st = container_of(hw, struct lrw_struct, hw);
+
+	pr_info("%s: unregister %s\n",
+		LORAWAN_MODULE_NAME, dev_name(&lrw_st->dev));
+
+	/* Stop and remove the LoRaWAM hardware from system */
+	if (lrw_st->state != LRW_STOP)
+		lrw_stop_hw(lrw_st);
+	device_del(&lrw_st->dev);
+	lrw_remove_hw(lrw_st);
+
+	return;
+}
+EXPORT_SYMBOL(lrw_unregister_hw);
+
+static int __init
+lrw_init(void)
+{
+	int err;
+
+	pr_info("%s: module inserted\n", LORAWAN_MODULE_NAME);
+
+	/* Create device class */
+	lrw_sys_class = class_create(THIS_MODULE, LORAWAN_MODULE_NAME);
+	if (IS_ERR(lrw_sys_class)) {
+		pr_err("%s: Failed to create a class of LoRaWAN\n",
+		       LORAWAN_MODULE_NAME);
+		err = PTR_ERR(lrw_sys_class);
+		goto lrw_init_end;
+	}
+
+	pr_debug("%s: class created\n", LORAWAN_MODULE_NAME);
+
+	/* Initial LoRaWAN socket API */
+	err = lrw_sock_init();
+
+lrw_init_end:
+	return err;
+}
+
+static void __exit
+lrw_exit(void)
+{
+	/* Release LoRaWAN socket API */
+	lrw_sock_exit();
+	/* Delete device class */
+	class_destroy(lrw_sys_class);
+	pr_info("%s: module removed\n", LORAWAN_MODULE_NAME);
+
+	return;
+}
+
+module_init(lrw_init);
+module_exit(lrw_exit);
+
+MODULE_AUTHOR("Jian-Hong Pan, <starnight@g.ncu.edu.tw>");
+MODULE_DESCRIPTION("LoRaWAN kernel module");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/net/maclorawan/socket.c b/net/maclorawan/socket.c
new file mode 100644
index 000000000000..cfb4156ec556
--- /dev/null
+++ b/net/maclorawan/socket.c
@@ -0,0 +1,700 @@
+/*-
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    similar to the "NO WARRANTY" disclaimer below ("Disclaimer") and any
+ *    redistribution must be conditioned upon including a substantially
+ *    similar Disclaimer requirement for further binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF NONINFRINGEMENT, MERCHANTIBILITY
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY,
+ * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
+ * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#include <linux/list.h>
+#include <linux/net.h>
+#include <linux/if_arp.h>
+#include <linux/termios.h>	/* For TIOCOUTQ/INQ */
+#include <net/sock.h>
+
+#include "lorawan.h"
+
+struct dgram_sock {
+	struct sock sk;
+	u32 src_devaddr;
+
+	unsigned int bound:1;
+	unsigned int connected:1;
+	unsigned int want_ack:1;
+	unsigned int secen:1;
+	unsigned int secen_override:1;
+	unsigned int seclevel:3;
+	unsigned int seclevel_override:1;
+};
+
+static HLIST_HEAD(dgram_head);
+static DEFINE_RWLOCK(dgram_lock);
+
+inline struct dgram_sock *
+dgram_sk(const struct sock *sk)
+{
+	return container_of(sk, struct dgram_sock, sk);
+}
+
+inline struct net_device *
+lrw_get_dev_by_addr(struct net *net, u32 devaddr)
+{
+	struct net_device *ndev = NULL;
+	__be32 be_addr = cpu_to_be32(devaddr);
+
+	rcu_read_lock();
+	ndev = dev_getbyhwaddr_rcu(net, ARPHRD_LORAWAN, (char *)&be_addr);
+	if (ndev)
+		dev_hold(ndev);
+	rcu_read_unlock();
+
+	return ndev;
+}
+
+inline struct lrw_mac_cb *
+mac_cb(struct sk_buff *skb)
+{
+	return (struct lrw_mac_cb *)skb->cb;
+}
+
+static int
+dgram_init(struct sock *sk)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+
+	ro->want_ack = 1;
+	return 0;
+}
+
+static void
+dgram_close(struct sock *sk, long timeout)
+{
+	sk_common_release(sk);
+}
+
+static int
+dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
+{
+	struct sockaddr_lorawan *addr = (struct sockaddr_lorawan *)uaddr;
+	struct dgram_sock *ro = dgram_sk(sk);
+	struct net_device *ndev;
+	int ret;
+
+	lock_sock(sk);
+	ro->bound = 0;
+
+	ret = -EINVAL;
+	if (len < sizeof(*addr))
+		goto dgram_bind_end;
+
+	if (addr->family != AF_LORAWAN)
+		goto dgram_bind_end;
+
+	if (addr->addr_in.addr_type != LRW_ADDR_DEVADDR)
+		goto dgram_bind_end;
+
+	pr_debug("lorawan: %s: bind address %X\n", __func__, addr->addr_in.devaddr);
+	ndev = lrw_get_dev_by_addr(sock_net(sk), addr->addr_in.devaddr);
+	if (!ndev) {
+		ret = -ENODEV;
+		goto dgram_bind_end;
+	}
+	netdev_dbg(ndev, "%s: get ndev\n", __func__);
+
+	if (ndev->type != ARPHRD_LORAWAN) {
+		ret = -ENODEV;
+		goto dgram_bind_end;
+	}
+
+	ro->src_devaddr = addr->addr_in.devaddr;
+	ro->bound = 1;
+	ret = 0;
+	dev_put(ndev);
+	pr_debug("lorawan: %s: bound address %X\n", __func__, ro->src_devaddr);
+
+dgram_bind_end:
+	release_sock(sk);
+	return ret;
+}
+
+inline int
+lrw_dev_hard_header(struct sk_buff *skb, struct net_device *ndev,
+		    const u32 src_devaddr, size_t len)
+{
+	/* TODO: Prepare the LoRaWAN sending header here */
+	return 0;
+}
+
+static int
+dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	size_t hlen;
+	size_t mtu;
+	size_t tlen;
+	int ret;
+
+	pr_debug("%s: %s: going to send %zu bytes", LORAWAN_MODULE_NAME, __func__, size);
+	if (msg->msg_flags & MSG_OOB) {
+		pr_debug("%s: msg->msg_flags = 0x%x\n", LORAWAN_MODULE_NAME, msg->msg_flags);
+		return -EOPNOTSUPP;
+	}
+
+	pr_debug("%s: %s: check msg_name\n", LORAWAN_MODULE_NAME, __func__);
+	if (!ro->connected && !msg->msg_name)
+		return -EDESTADDRREQ;
+	else if (ro->connected && msg->msg_name)
+		return -EISCONN;
+
+	pr_debug("%s: %s: check bound\n", LORAWAN_MODULE_NAME, __func__);
+	if (!ro->bound)
+		ndev = dev_getfirstbyhwtype(sock_net(sk), ARPHRD_LORAWAN);
+	else
+		ndev = lrw_get_dev_by_addr(sock_net(sk), ro->src_devaddr);
+
+	if (!ndev) {
+		pr_debug("%s: no dev\n", LORAWAN_MODULE_NAME);
+		ret = -ENXIO;
+		goto dgram_sendmsg_end;
+	}
+
+	/* TODO: MTU should be the regional defined */
+	mtu = LORAWAN_MTU;
+	if (size > mtu){
+		netdev_dbg(ndev, "size = %zu, mtu = %zu\n", size, mtu);
+		ret = -EMSGSIZE;
+		goto dgram_sendmsg_end;
+	}
+
+	netdev_dbg(ndev, "%s: create skb\n", __func__);
+	hlen = LL_RESERVED_SPACE(ndev);
+	tlen = ndev->needed_tailroom;
+	skb = sock_alloc_send_skb(sk, hlen + tlen + size,
+				  msg->msg_flags & MSG_DONTWAIT,
+				  &ret);
+
+	if (!skb)
+		goto dgram_sendmsg_no_skb;
+
+	skb_reserve(skb, hlen);
+	skb_reset_network_header(skb);
+
+	ret = lrw_dev_hard_header(skb, ndev, ro->bound ? ro->src_devaddr : 0, size);
+	if (ret < 0)
+		goto dgram_sendmsg_no_skb;
+
+	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
+	if (ret > 0)
+		goto dgram_sendmsg_err_skb;
+
+	skb->dev = ndev;
+	skb->protocol = htons(ETH_P_LORAWAN);
+
+	netdev_dbg(ndev, "%s: push skb to xmit queue\n", __func__);
+	ret = dev_queue_xmit(skb);
+	if (ret > 0)
+		ret = net_xmit_errno(ret);
+	netdev_dbg(ndev, "%s: pushed skb to xmit queue with ret=%d\n", __func__, ret);
+	dev_put(ndev);
+
+	return ret ?: size;
+
+dgram_sendmsg_err_skb:
+	kfree_skb(skb);
+dgram_sendmsg_no_skb:
+	dev_put(ndev);
+
+dgram_sendmsg_end:
+	return ret;
+}
+
+static int
+dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+	      int noblock, int flags, int *addr_len)
+{
+	struct sk_buff *skb;
+	size_t copied = 0;
+	DECLARE_SOCKADDR(struct sockaddr_lorawan *, saddr, msg->msg_name);
+	int err;
+
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb)
+		goto dgram_recvmsg_end;
+
+	copied = skb->len;
+	if (len < copied) {
+		msg->msg_flags |= MSG_TRUNC;
+		copied = len;
+	}
+
+	err = skb_copy_datagram_msg(skb, 0, msg, copied);
+	if (err)
+		goto dgram_recvmsg_done;
+
+	sock_recv_ts_and_drops(msg, sk, skb);
+	if(saddr) {
+		memset(saddr, 0, sizeof(*saddr));
+		saddr->family = AF_LORAWAN;
+		saddr->addr_in.devaddr = mac_cb(skb)->devaddr;
+		*addr_len = sizeof(*saddr);
+	}
+
+	if (flags & MSG_TRUNC)
+		copied = skb->len;
+
+dgram_recvmsg_done:
+	skb_free_datagram(sk, skb);
+
+dgram_recvmsg_end:
+	if (err)
+		return err;
+	return copied;
+}
+
+static int
+dgram_hash(struct sock *sk)
+{
+	pr_debug("lorawan: %s\n", __func__);
+	write_lock_bh(&dgram_lock);
+	sk_add_node(sk, &dgram_head);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+	write_unlock_bh(&dgram_lock);
+
+	return 0;
+}
+
+static void
+dgram_unhash(struct sock *sk)
+{
+	pr_debug("lorawan: %s\n", __func__);
+	write_lock_bh(&dgram_lock);
+	if (sk_del_node_init(sk))
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	write_unlock_bh(&dgram_lock);
+}
+
+static int
+dgram_connect(struct sock *sk, struct sockaddr *uaddr, int len)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+
+	/* Nodes of LoRaWAN send data to a gateway only, then data is received
+	 * and transferred to servers with the gateway's policy.
+	 * So, the destination address is not used by nodes.
+	 */
+	lock_sock(sk);
+	ro->connected = 1;
+	release_sock(sk);
+
+	return 0;
+}
+
+static int
+dgram_disconnect(struct sock *sk, int flags)
+{
+	struct dgram_sock *ro = dgram_sk(sk);
+
+	lock_sock(sk);
+	ro->connected = 0;
+	release_sock(sk);
+
+	return 0;
+}
+
+static int
+dgram_ioctl(struct sock *sk, int cmd, unsigned long arg)
+{
+	struct sk_buff *skb;
+	int amount;
+	int err;
+	struct net_device *ndev = sk->sk_dst_cache->dev;
+
+	netdev_dbg(ndev, "%s: ioctl file (cmd=0x%X)\n", __func__, cmd);
+	switch (cmd) {
+	case SIOCOUTQ:
+		amount = sk_wmem_alloc_get(sk);
+		err = put_user(amount, (int __user *)arg);
+		break;
+	case SIOCINQ:
+		amount = 0;
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+		skb = skb_peek(&sk->sk_receive_queue);
+		if (skb) {
+			/* We will only return the amount of this packet
+			 * since that is all that will be read.
+			 */
+			amount = skb->len - 0;//lrw_hdr_length(skb);
+		}
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+		err = put_user(amount, (int __user *)arg);
+		break;
+	default:
+		err = -ENOIOCTLCMD;
+	}
+
+	return err;
+}
+
+static int
+dgram_getsockopt(struct sock *sk, int level, int optname,
+		 char __user *optval, int __user *optlen)
+{
+	int val, len;
+
+	if (level != SOL_LORAWAN)
+		return -EOPNOTSUPP;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(int));
+
+	switch (optname) {
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (put_user(len, optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &val, len))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int
+dgram_setsockopt(struct sock *sk, int level, int optname,
+		 char __user *optval, unsigned int optlen)
+{
+	int val;
+	int err = 0;
+
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (get_user(val, (int __user *)optval))
+		return -EFAULT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+
+	return err;
+}
+
+static struct proto lrw_dgram_prot = {
+	.name		= "LoRaWAN-MAC",
+	.owner		= THIS_MODULE,
+	.obj_size	= sizeof(struct dgram_sock),
+	.init		= dgram_init,
+	.close		= dgram_close,
+	.bind		= dgram_bind,
+	.sendmsg	= dgram_sendmsg,
+	.recvmsg	= dgram_recvmsg,
+	.hash		= dgram_hash,
+	.unhash		= dgram_unhash,
+	.connect	= dgram_connect,
+	.disconnect	= dgram_disconnect,
+	.ioctl		= dgram_ioctl,
+	.getsockopt	= dgram_getsockopt,
+	.setsockopt	= dgram_setsockopt,
+};
+
+static int
+lrw_sock_release(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (sk) {
+		sock->sk = NULL;
+		sk->sk_prot->close(sk, 0);
+	}
+
+	return 0;
+}
+
+static int
+lrw_sock_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	struct sock *sk = sock->sk;
+	struct sockaddr_lorawan *addr = (struct sockaddr_lorawan *)uaddr;
+
+	pr_debug("lorawan: %s: bind address %X\n", __func__, addr->addr_in.devaddr);
+	if (sk->sk_prot->bind)
+		return sk->sk_prot->bind(sk, uaddr, addr_len);
+
+	return sock_no_bind(sock, uaddr, addr_len);
+}
+
+static int
+lrw_sock_connect(struct socket *sock, struct sockaddr *uaddr,
+		 int addr_len, int flags)
+{
+	struct sock *sk = sock->sk;
+
+	if (addr_len < sizeof(uaddr->sa_family))
+		return -EINVAL;
+
+	return sk->sk_prot->connect(sk, uaddr, addr_len);
+}
+
+static int
+lrw_ndev_ioctl(struct sock *sk, struct ifreq __user *arg, unsigned int cmd)
+{
+	struct ifreq ifr;
+	int ret = -ENOIOCTLCMD;
+	struct net_device *ndev;
+
+	pr_debug("lorawan: %s: cmd %ud\n", __func__, cmd);
+	if (copy_from_user(&ifr, arg, sizeof(struct ifreq)))
+		return -EFAULT;
+
+	ifr.ifr_name[IFNAMSIZ-1] = 0;
+
+	dev_load(sock_net(sk), ifr.ifr_name);
+	ndev = dev_get_by_name(sock_net(sk), ifr.ifr_name);
+
+	netdev_dbg(ndev, "%s: cmd %ud\n", __func__, cmd);
+	if (!ndev)
+		return -ENODEV;
+
+	if (ndev->type == ARPHRD_LORAWAN && ndev->netdev_ops->ndo_do_ioctl)
+		ret = ndev->netdev_ops->ndo_do_ioctl(ndev, &ifr, cmd);
+
+	if (!ret && copy_to_user(arg, &ifr, sizeof(struct ifreq)))
+		ret = -EFAULT;
+	dev_put(ndev);
+
+	return ret;
+}
+
+static int
+lrw_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
+{
+	struct sock *sk = sock->sk;
+
+	pr_debug("lorawan: %s: cmd %ud\n", __func__, cmd);
+	switch (cmd) {
+	case SIOCGSTAMP:
+		return sock_get_timestamp(sk, (struct timeval __user *)arg);
+	case SIOCGSTAMPNS:
+		return sock_get_timestampns(sk, (struct timespec __user *)arg);
+	case SIOCOUTQ:
+	case SIOCINQ:
+		if (!sk->sk_prot->ioctl)
+			return -ENOIOCTLCMD;
+		return sk->sk_prot->ioctl(sk, cmd, arg);
+	default:
+		return lrw_ndev_ioctl(sk, (struct ifreq __user *)arg, cmd);
+	}
+}
+
+static int
+lrw_sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+{
+	struct sock *sk = sock->sk;
+
+	pr_debug("%s: going to send %zu bytes\n", __func__, len);
+	return sk->sk_prot->sendmsg(sk, msg, len);
+}
+
+static const struct proto_ops lrw_dgram_ops = {
+	.family		= PF_LORAWAN,
+	.owner		= THIS_MODULE,
+	.release	= lrw_sock_release,
+	.bind		= lrw_sock_bind,
+	.connect	= lrw_sock_connect,
+	.socketpair	= sock_no_socketpair,
+	.accept		= sock_no_accept,
+	.getname	= sock_no_getname,
+	.poll		= datagram_poll,
+	.ioctl		= lrw_sock_ioctl,
+	.listen		= sock_no_listen,
+	.shutdown	= sock_no_shutdown,
+	.setsockopt	= sock_common_setsockopt,
+	.getsockopt	= sock_common_getsockopt,
+	.sendmsg	= lrw_sock_sendmsg,
+	.recvmsg	= sock_common_recvmsg,
+	.mmap		= sock_no_mmap,
+	.sendpage	= sock_no_sendpage,
+};
+
+static int
+lorawan_creat(struct net *net, struct socket *sock, int protocol, int kern)
+{
+	struct sock *sk;
+	int ret;
+
+	if (!net_eq(net, &init_net))
+		return -EAFNOSUPPORT;
+
+	if (sock->type != SOCK_DGRAM)
+		return -EAFNOSUPPORT;
+
+	sk = sk_alloc(net, PF_LORAWAN, GFP_KERNEL, &lrw_dgram_prot, kern);
+	if (!sk)
+		return -ENOMEM;
+
+	sock->ops = &lrw_dgram_ops;
+	sock_init_data(sock, sk);
+	sk->sk_family = PF_LORAWAN;
+	sock_set_flag(sk, SOCK_ZAPPED);
+
+	if (sk->sk_prot->hash) {
+		ret = sk->sk_prot->hash(sk);
+		if (ret) {
+			sk_common_release(sk);
+			goto lorawan_creat_end;
+		}
+	}
+
+	if (sk->sk_prot->init) {
+		ret = sk->sk_prot->init(sk);
+		if (ret)
+			sk_common_release(sk);
+	}
+
+lorawan_creat_end:
+	return ret;
+}
+
+static const struct net_proto_family lorawan_family_ops = {
+	.owner		= THIS_MODULE,
+	.family		= PF_LORAWAN,
+	.create		= lorawan_creat,
+};
+
+inline int
+lrw_dgram_deliver(struct net_device *ndev, struct sk_buff *skb)
+{
+	struct lrw_struct *lrw_st = NETDEV_2_LRW(ndev);
+	struct sock *sk;
+	struct dgram_sock *ro;
+	bool found = false;
+	int ret = NET_RX_SUCCESS;
+
+	read_lock(&dgram_lock);
+	sk_for_each(sk, &dgram_head) {
+		ro = dgram_sk(sk);
+		if(cpu_to_le32(ro->src_devaddr) == lrw_st->devaddr) {
+			found = true;
+			break;
+		}
+	}
+	read_unlock(&dgram_lock);
+
+	if (!found)
+		goto lrw_dgram_deliver_err;
+
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
+	if (sock_queue_rcv_skb(sk, skb) < 0)
+		goto lrw_dgram_deliver_err;
+
+	return ret;
+
+lrw_dgram_deliver_err:
+	kfree_skb(skb);
+	ret = NET_RX_DROP;
+	return ret;
+}
+
+static int
+lorawan_rcv(struct sk_buff *skb, struct net_device *ndev,
+	    struct packet_type *pt, struct net_device *orig_ndev)
+{
+	if (!netif_running(ndev))
+		goto lorawan_rcv_drop;
+
+	if (!net_eq(dev_net(ndev), &init_net))
+		goto lorawan_rcv_drop;
+
+	if (ndev->type != ARPHRD_LORAWAN)
+		goto lorawan_rcv_drop;
+
+	if (skb->pkt_type != PACKET_OTHERHOST)
+		return lrw_dgram_deliver(ndev, skb);
+
+lorawan_rcv_drop:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
+static struct packet_type lorawan_packet_type = {
+	.type		= htons(ETH_P_LORAWAN),
+	.func		= lorawan_rcv,
+};
+
+int
+lrw_sock_init(void)
+{
+	int ret;
+
+	ret = proto_register(&lrw_dgram_prot, 1);
+	if(ret)
+		goto lrw_sock_init_end;
+
+	/* Tell SOCKET that we are alive */
+	ret = sock_register(&lorawan_family_ops);
+	if(ret)
+		goto lrw_sock_init_err;
+
+	dev_add_pack(&lorawan_packet_type);
+	ret = 0;
+	goto lrw_sock_init_end;
+
+lrw_sock_init_err:
+	proto_unregister(&lrw_dgram_prot);
+
+lrw_sock_init_end:
+	return 0;
+}
+
+void
+lrw_sock_exit(void)
+{
+	dev_remove_pack(&lorawan_packet_type);
+	sock_unregister(PF_LORAWAN);
+	proto_unregister(&lrw_dgram_prot);
+}
-- 
2.18.0
