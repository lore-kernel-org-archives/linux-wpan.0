Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:59513 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbaIZPQF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 11:16:05 -0400
Message-ID: <54258332.2010004@xsilon.com>
Date: Fri, 26 Sep 2014 16:16:02 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: ICMPv6 Redirects
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

I have three nodes running linux all running in promiscuous mode with 
ipv6 forwarding enabled. The kernel is built from wpan-next. The three 
nodes are all connected directly using 802.15.4.

Node A: fe80::203:9a00:0:a
Node B: fe80::203:9a00:0:b
Node C: fe80::203:9a00:0:c

If from node A I ping node B I get ICMP redirects from node C. Node C 
also forwards the packet to node B so node B receives the ping request 
twice.

If I try a similar setup using ethernet instead of 802.15.4 I do not get 
this problem.

Has anyone else seen this?

Simon


