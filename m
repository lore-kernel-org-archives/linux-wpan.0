Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from inet.dresden-elektronik.de ([84.19.195.242]:47591 "EHLO
	inet.dresden-elektronik.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbbCBIoa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 2 Mar 2015 03:44:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by inet.dresden-elektronik.de (Postfix) with ESMTP id 3F0133425B2
	for <linux-wpan@vger.kernel.org>; Mon,  2 Mar 2015 09:44:29 +0100 (CET)
Received: from inet.dresden-elektronik.de ([127.0.0.1])
	by localhost (inet.dresden-elektronik.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7tmPi744y2e for <linux-wpan@vger.kernel.org>;
	Mon,  2 Mar 2015 09:44:15 +0100 (CET)
Received: from SRV-DE08.ddel.de (unknown [192.168.192.188])
	by inet.dresden-elektronik.de (Postfix) with ESMTPS id 1D79E342207
	for <linux-wpan@vger.kernel.org>; Mon,  2 Mar 2015 09:44:15 +0100 (CET)
From: "Ludwig, Mike" <ml@dresden-elektronik.de>
Subject: [linux-wpan] mac802154 development
Date: Mon, 2 Mar 2015 08:44:12 +0000
Message-ID: <02E1EC3037481742A4C5830E984A9E9AA47BE3@SRV-DE08.ddel.de>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

after a few days checking through the mainline and bluetooth-next kernel regarding ieee/mac802154 and 6LoWPAN I'm rather puzzled about the current status and future developments. 

As the mac802154 is under rework I tried to follow the lines of a hardMAC (e.g. as fakehard.ko is doing it) thereby bypassing the mac802154 business completely. I started creating a serial driver that allows the attachment of a radio over a serial line on the MAC layer interface. The netlink routines did look quite promising. 

Unfortunately I'm now already stuck at the scan request - or to be more precise at the scan response. In my understanding it is always the first step for any device (FFD or RFD) to scan for existing networks. In mainline at lease the results of a ED scan can be passed back via netlink. In bluetooth-next even the scan confirmation is gone. Is this for a reason?
Moreover, to do some real work by joining an existing WPAN a pan_desciptor_list would have to be passed back to netlink. 
I did not go further in checking on the start/associate/disassociate netlink parts as it would always be a crutch to create/join WPANs without working scans. 

So this is more about seeking advice than implementation details. I'm quite happy to do add missing pieces to the netlink part but would like to do this in line with the rework of the MAC if this would have implications on that. It would be great if you could give me some hints on proceeding and may on the plans for the rework. I guess you already have some ideas on required changes an might point me to the right locations. Thanks a lot for your help.


Best regards

Mike Ludwig

