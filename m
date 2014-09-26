Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:47081 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbaIZIGU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 04:06:20 -0400
Received: by mail-wi0-f181.google.com with SMTP id z2so10982031wiv.2
        for <linux-wpan@vger.kernel.org>; Fri, 26 Sep 2014 01:06:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 0/3] mac: info: interface: add basic support
Date: Fri, 26 Sep 2014 10:06:06 +0200
Message-Id: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series add support for setting lbt mode and dump phy parameters and
mac interface parameters.

Each interface "could" have different mac parameters, because the mac sublayer
means mac algorithmn which are done by phy. These parameters need to be the same
on each interface. There are couple of mac sublayer parameters like ARET, CSMA,
promiscuous mode, etc... These parameters will be changed if an interface will
comming up, otherwise it's there but not running. Solution to run this device
with different parameter is first down all others interfaces and then up the interface
with the different parameters. (Difficult to explain maybe it's clear when you play a
little bit with that).

PHY settings will directly set registers to the driver. There is no mac functionality.
Only physical changes in radio frequency handling.

dump example for phy pib:

root@DistroKit:~ iwpan phy
wpan_phy phy0
supported channels:
        page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26 
current_page: 0
current_channel: 26
cca_mode: 1
tx_power: 3

dump example for mac pib:

phy#0
        Interface mon0
                ifindex 5
                wpan_dev 0x2
                extended_addr 0x0000000000000000
                short_addr 0xffff
                pan_id 0xffff
                type monitor
                max_frame_retries 3
                max_be 5
                max_csma_backoffs 4
                min_be 3
                lbt 0
        Interface wpan0
                ifindex 2
                wpan_dev 0x1
                extended_addr 0xaaaaaaaaaaaaaaaa
                short_addr 0xffff
                pan_id 0xabcd
                type node
                max_frame_retries 3
                max_be 5
                max_csma_backoffs 4
                min_be 3
                lbt 0

I know there are a lot of other pib values. I don't forget these but it need
time to support it. I am still getting a state in the rework like mainline state.

Also it looks a little bit ugly but we can still change it for the wpan-tools. :-)

- Alex

Alexander Aring (3):
  mac: add support for setting lbt mode
  info: add support to dump phy pib
  interface: add dump for iface mac parameters

 src/Makefile.am |   1 +
 src/info.c      | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/interface.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/iwpan.h     |   3 ++
 src/mac.c       |  27 ++++++++++++++
 src/nl802154.h  |  13 +++++++
 src/nl_extras.h |   5 +++
 7 files changed, 258 insertions(+)
 create mode 100644 src/info.c

-- 
2.1.0

