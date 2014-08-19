Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34603 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaHSKGt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 06:06:49 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so5011832wib.11
        for <linux-wpan@vger.kernel.org>; Tue, 19 Aug 2014 03:06:48 -0700 (PDT)
Received: from omega (p20030064A97F040EE2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a97f:40e:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id mx10sm26937311wib.1.2014.08.19.03.06.47
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2014 03:06:47 -0700 (PDT)
Date: Tue, 19 Aug 2014 12:06:45 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: new netlink interface cfg802154
Message-ID: <20140819100643.GB827@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I will send in the next days a new implementation for the netlink
interface.

Why?

I don't know where I can begin to say what's wrong with the current
netlink interface. It has some half implemented features and the
userspace header (they are not in uapi) contains "extern ..." things for
the policy.

Right now the lowpan-tools supports add/del interfaces and setting of
hardware filter functionality, pan_id, short_address, nothing more.
There are some other userspace application (I know two) which talk
with this interface. Please don't be angry that you need to updated
the userspace application according the new one.




The new interface is like cfg80211, but with 802.15.4 functionality. I
begun to make everything like the wirless stack and then we can think
about bringing 802.15.4 functionality into this stack.

Also I implemented a new userspace tool package "wpan-tools" [0].

This will contain the iwpan tool. This code is mostly based on the iw
tool from wireless [1]. It currently support adding new interface and
delete exist interfaces. It's very modular and we can easy add new
netlink features.

The nl802154.h should not updated in the wpan-tools, it should updated
on the kernel side.

I will send the cfg802154 patches to this mailinglist, when I get basic
support for channel and pan id setting.

- Alex

[0] https://github.com/linux-wpan/wpan-tools
[1] http://git.kernel.org/cgit/linux/kernel/git/jberg/iw.git
