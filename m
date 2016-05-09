Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from pv36p08im-ztdg07111401.me.com ([17.142.193.35]:33448 "EHLO
	pv36p08im-ztdg07111401.me.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753436AbcEIX5Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 9 May 2016 19:57:16 -0400
Received: from process-dkim-sign-daemon.pv36p08im-ztdg07111401.me.com by
 pv36p08im-ztdg07111401.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 id <0O6X00I00ME0BW00@pv36p08im-ztdg07111401.me.com> for
 linux-wpan@vger.kernel.org; Mon, 09 May 2016 22:57:06 +0000 (GMT)
Received: from [172.16.7.80] (nat60-181.net.kcls.org [206.188.60.181])
 by pv36p08im-ztdg07111401.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 with ESMTPSA id <0O6X00BH0MF43Z30@pv36p08im-ztdg07111401.me.com> for
 linux-wpan@vger.kernel.org; Mon, 09 May 2016 22:57:05 +0000 (GMT)
From: Guangyu Pei <guangyu.pei@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
Subject: How to move wpan interface to another interface?
Message-id: <D8027A82-319B-4FB7-AB44-C72B827B827E@icloud.com>
Date: Mon, 09 May 2016 15:57:05 -0700
MIME-version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

Command “ip link set wpan0 netns pid” returns “RTNETLINK answers: Invalid argument”. For 802.11, we have “iw phy phy1 set netns pid”. But for iwpan, it seems that there is no such option. I need to run some experiments with fakelb driver and hope that I can move wpan devices to different network namespaces.

Would you please let me know whether there is a workaround or I miss anything?

Thanks,

Gary