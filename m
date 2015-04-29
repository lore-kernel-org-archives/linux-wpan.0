Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38460 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422717AbbD2KyC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 06:54:02 -0400
Received: by wiun10 with SMTP id n10so61017873wiu.1
        for <linux-wpan@vger.kernel.org>; Wed, 29 Apr 2015 03:54:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] architecture: general: initial commit
Date: Wed, 29 Apr 2015 12:51:33 +0200
Message-Id: <1430304693-18629-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a new directory which contains explanatians (ascii art
or in text) about behaviours in the linux-wpan stack implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 architecture/README              |   3 ++
 architecture/general/wpan        | 107 +++++++++++++++++++++++++++++++++++++++
 architecture/general/wpan_asciio | Bin 0 -> 8616 bytes
 3 files changed, 110 insertions(+)
 create mode 100644 architecture/README
 create mode 100644 architecture/general/wpan
 create mode 100644 architecture/general/wpan_asciio

diff --git a/architecture/README b/architecture/README
new file mode 100644
index 0000000..d3c8330
--- /dev/null
+++ b/architecture/README
@@ -0,0 +1,3 @@
+ascii diagrams are generated with asciio:
+
+http://search.cpan.org/dist/App-Asciio/lib/App/Asciio.pm
diff --git a/architecture/general/wpan b/architecture/general/wpan
new file mode 100644
index 0000000..8a372b8
--- /dev/null
+++ b/architecture/general/wpan
@@ -0,0 +1,107 @@
+              .-------------------------------------------------------------------------------------------------------.
+              |                                               Userspace                                               |
+              '-----------------^----------------------------------^----------------------------------^---------------'
+                                |                                  | socket                           |
+                                |                                  v                                  |
+                                |                  .------------------------------.                   |
+                                | socket           |             IPv6             |                   |
+                                |                  '------------------------------'                   | netlink
+                                |                                         ^                           |
+             .------------------|-----------------------------------------|---------------------------|-----------------.
+             |                  |                             ieee802154  |                           |                 |
+             |------------------|-----------------------------------------|---------------------------|-----------------|
+             |                  v                                         v                           |                 |
+             | .---------------------------------. .-----------------------------.                    |                 |
+             | |        802.15.4 Sockets         | |      802.15.4 6LoWPAN       |                    |                 |
+             | |---------------------------------| |-----------------------------|    .---------------v-------------.   |
+             | |.--------------. .--------------.| |                             |    |          nl802154           |   |
+             | ||    DGRAM     | |     RAW      || |  .-----------------------.  |    |-----------------------------|   |
+             | || data payload | |  full frame  || |  |    Generic 6LoWPAN    |  |    |                             |   |
+             | |'------^-------' '--------------'| |  | .-------------------. |  |    |  .----------. .-----------. |   |
+             | |       |                | ^      | |  | |        NHC        | |  |    |  |   mlme   | | cmd, etc. | |   |
+             | |       |                | |      | |  | '-------------------' |  |    |  |----------| |-----------| |   |
+             | |       v                | |      | |  '-------------^---------'  |    |  | assoc.   | | panid     | |   |
+             | | .------------.         | |      | |                |            |    |  | deassoc. | | channel   | |   |
+             | | | dataframes |       tx| | rx   | |       .--------v--------.   |    |  | ...      | | ...       | |   |
+             | | '------------'         | |      | |       |   dataframes    |   |    |  '----------' '-----------' |   |
+             | |     |    ^             | |      | |       '-------^-|-------'   |    |       |             ^       |   |
+             | '-----|----|-------------|-|------' '---------------|-|-----------'    |       |             |       |   |
+             |       |    |             | |-----------.            | |                |       |             |       |   |
+             |    tx |    |rx           '-------|     |            | |                '-------|-------------|-------'   |
+             |       |    |---------------------|-----|------.   rx| |tx                      |             |           |
+             |       v                          |     |      |     | |                        |             |           |
+             | .------------------------------. |     |      |     | |                        |             |           |
+             | |        frame creation        | |     |      |     | |                        |             |           |
+             | |------------------------------| |     |      |     | |                        |             |           |
+             | | generic functions            <-|-----|--------------'                        |             |           |
+             | | - wpan_dev callbacks struct? | |     |      |     |                          |             |           |
+             | |   instead dev_hard_header    | |     |      |     |   .-------------------.  |             |           |
+         ******|   different HardMAC/SoftMAC  | |     |      |     |   |  mlme operations  |  |             |           |
+         *   | | - data                       | |     |      |     |   |                   |<-'             |           |
+         *   | | --- for mlme ---             | |     |      |     |   '-------------------'                |           |
+         *   | | - beacon                     | |     |      |     |                |                       |           |
+         *   | | - cmd                        | |     |      |     |                |                       |           |
+         *   | | - ack? -> (slotted mode)     | |     |      |     |                |                       |           |
+         *   | '--------------|---------------' |.-------------------------.        |                       |           |
+         *   |                v                 ||  802.15.4 packet_layer  |        |             ----------'           |
+         *   |       .----------------.         |'-------------------------'        |             |                     |
+         *   |       | dev_queue_xmit |<--------'            ^                      |             |                     |
+         *   |       '----------------'                      |                      |             |                     |
+         *   '----------------|------------------------------|----------------------|-------------|---------------------'
+         *              .-----|------------------------------|----------------------|-------------|------------.
+         *              |     |                              | mac802154            |             |            |
+         *              |-----|------------------------------|----------------------v-------------v------------|
+         *              |     |                              |               .-------------..-----------.      |
+         *******************************************************************>| do mlme ops || cfg802154 |      |
+can use frame creation  |     |   .--------------------------|-------------. '-------------'|-----------|      |
+                        |     |   | Frame parsing (call netif_receive_skb) |        |       | panid     |--------|
+                        |     |   |----------------------------------------|        |       | shortaddr |      | |
+                        |     |   | again check if 802.15.4 compliant      |        |       | etc.      |      | |
+                        |     |   | different handling coordinator/node    |        |       '-----------'      | |
+                        |     |   | set packet type (e.g. PACKET_HOST)     |        |                          | |
+                        |     |   '---------------------^------------------'        |                          | |
+                        |     |                         |                           | tx workqueue             | |
+                        |     |ndo_start_xmit           |   |-----------------------'                          | |  .--------------.
+                        |     |      .------------------|---|--------------------------------------.           | |  | e.g. tcpdump |
+                        |     |      |                  |   |interface types                       |           | |  '--------------'
+                        |     |      |------------------|---|--------------------------------------|           | |          ^
+                        |     |      |                  |   |                                      |           | |          |
+                        |     |      | .----------------|---v-----------.  .---------------------. |           | |          |
+                        |     |      | |             frames             |  |       frames        | | mac sett. | |    .-----------.
+                        |     '-------->    for rx, filtered by phy     |  | non-filtered by phy | |<------------|    | af_packet |
+                        |            | |--------------------------------|  |---------------------| |           | |    '-----------'
+                        |        .---| |                                |  |                     |----.        | |          ^
+                        |        |   | | .-------------.  .-----------. |  | .-----------.       | |  |        | |          |
+                        |        |   | | | coordinator |  |   node    | |  | |  monitor  |-----------------------|----------'
+                        |        |   | | '------^------'  '-----^-----' |  | '-----------'       | |  |        | |
+                        |        |   | '--------|---------------|-------'  '-------^-------------' |  |        | |
+                        |        |   '----------|---------------|------------------|---------------'  |        | |
+                        |        |              | rx/tx         | rx/tx            |rx/tx not possible(no AACK)| |
+                        |        |              |               |         |--------|                  |        | |
+                        '--------|--------------|---------------|---------|--------|------------------|--------' |
+                                 |              v               v         |        |                  |          |
+                                 |         ===================================     |                  |          |
+                                 |               ^          ^          ^           |                  |          |
+                                 |        .------|----------|----------|-----------|------.           |          |
+    each interface type has      |        |      |          |  Frames  |           |      |           |     if AACK, ack frames are handled   
+    different phy address filters|        |------|----------|----------|-----------|------|           |     by phy layer, not driver.         
+    - sets mac settings on ifup  |        | .----v----..----v----..----v----. .---------. |  AACK ----|--->                                   
+                                 |        | |  data   ||   cmd   || beacon  | |   ack   |------.      |     AACK disabled if promiscuous mode.
+                                 |        | '----^----''----^----''----^----' '----^----' |    |      |     Then driver receives ack frames.  
+                                 |        '------|----------|----------|-----------.------'    |      |          |
+                                 |               |          |          |           .           |      |          |
+                                 |               |          |          |           .           |      | sets promiscuous mode
+                                 |        .------v----------v----------v-----------v------.    |      |          |
+                                 |        |            802.15.4 SoftMAC Driver            |    |      |          |
+                                 |        |-----------------------------------------------|    |      |          |
+                                 |        | - supports always AACK handling               |    |      |          |
+                                 -------->|   - ACK handling is done by phy (AACK)        |<-----------          |
+                                          |   - on AACK, ACK frames doesn't reach driver  |<----------------------
+                                          | - filtering (CRC, address, what phy can do..) |    |   phy settings
+                                          '-----------------------------------------------'    |
+                                                                  ^                            |
+                                                                  |                            |
+                                                                  v                            |
+                                                      .----------------------.                 |
+                                                      | 802.15.4 SoftMAC PHY |<----------------'
+                                                      '----------------------'
diff --git a/architecture/general/wpan_asciio b/architecture/general/wpan_asciio
new file mode 100644
index 0000000000000000000000000000000000000000..6269a3fb9a8aff440402256b11c9571ea409d88e
GIT binary patch
literal 8616
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

literal 0
HcmV?d00001

-- 
2.3.6

