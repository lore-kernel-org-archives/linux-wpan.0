Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52288 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758064AbaJ3Jm5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Oct 2014 05:42:57 -0400
Message-ID: <5452081F.5090706@xsilon.com>
Date: Thu, 30 Oct 2014 09:42:55 +0000
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: problems with udp header compression
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

I think I have stumbled across a bug in the udp header compression or 
possibly in a higher layer of the network stack.

If I send a UDP message using a RAW socket[0] the src and dest port 
numbers get corrupted on 802.15.4 devices. This does not occur on ethernet.

If I print out the udp source and destination ports in 
compress_udp_header they are incorrect. The function udp_hdr is not 
pointing at the udp header but actually the ip6 header.

If I send a UDP message using a normal UDP socket I do not have this 
problem.

Any ideas?

Simon

[0] - socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
