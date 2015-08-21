Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58999 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbbHUJLH (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 21 Aug 2015 05:11:07 -0400
Received: from [192.168.2.22] (pD9F79E8A.dip0.t-ipconnect.de [217.247.158.138])
	by lists.s-osg.org (Postfix) with ESMTPSA id DCE49462A0
	for <linux-wpan@vger.kernel.org>; Fri, 21 Aug 2015 02:11:05 -0700 (PDT)
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: wpan-tools 0.5 release
Message-ID: <55D6EB26.7070902@osg.samsung.com>
Date: Fri, 21 Aug 2015 11:11:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

It is a pleasure to announce the 0.5 release of wpan-tools.
Thanks to everyone who contributed!

Downloads and md5sums:

http://wpan.cakelab.org/releases/wpan-tools-0.5.tar.bz2
6226df405a98c13ec41bf4d1f0777d6b

http://wpan.cakelab.org/releases/wpan-tools-0.5.tar.gz
c6356f7be4de2e9f2084283b9ed7e1ab


Alexander Aring (8):
       interface: use hexadecimal for print extended addr
       treewide: change transmit power to mbm
       info: add support for phy capability dump
       info: change dbm format string
       phy: fix cca ed level parameter parsing
       info: fix tx power printout
       info: add support for cca ed level info
       mac: add handling for ackreq default handling

Christoffer Holmstedt (5):
       info: fix printf taking the wrong amount of arguments
       info: add frequency to channel listing for phy capabilities
       info: add frequency output to current channel
       nl802154: fix misspelled enum
       info: update CCA mode and CCA options output

Guido Günther (1):
       Use PRIu64 for formatting uint64_t

Stefan Schmidt (15):
       wpan-ping: Ping utility on IEEE 802.15.4 level
       wpan-ping: Add README for some basic usage descriptions.
       COPYRIGHT: Add my own copyright due to wpan-ping contribution
       wpan-ping: Take 6LoWPAN dispatch byte into account
       gitignore: use wildcard to ignore object files
       wpan-ping: Add .gitignore to ignore generated files
       wpan-ping: adjust maximal packet length for extended addresses
       wpan-ping: allow usage of extended addressing scheme
       wpan-ping: switch server indicator variable to bool
       wpan-ping: Reduce packet recv timeout to 500ms from 2s
       wpan-ping: unify src and dst address handling
       wpan-ping: use recvfrom and sendto isntead of connecting the socket
       build: remove leftover from Makefile.am
       mac/py: add range checks on arguments to avoid wrong value being set
       Release 0.5

Varka Bhadram (4):
       gitignore: add object files
       phy: convert tx power value
       nl802154: export supported commands
       interface: fix interface type info

regards
Stefan Schmidt
