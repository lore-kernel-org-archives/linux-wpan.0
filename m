Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52497 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaIBOV5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 10:21:57 -0400
Message-ID: <5405D284.7020606@xsilon.com>
Date: Tue, 02 Sep 2014 15:21:56 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: 6lowpan raw socket problems
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com> <20140901113835.GA21564@omega> <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com> <20140902071214.GA25800@omega> <20140902072627.GB25800@omega>
In-Reply-To: <20140902072627.GB25800@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

I am having problems with raw sockets on a 6lowpan 802.15.4 interface. 
The code works correctly on an ethernet ipv6 interface but not on a 
6lowpan interface. In the 6lowpan interface I receive packets but I find 
the src and dest addresses are incorrect.

I open the socket like this:
socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);

Add options for IPV6_RECVPKTINFO, IPV6_CHECKSUM, IPV6_RECVHOPLIMIT.

I then receive a packet using recvmsg and attempt to get the source 
address. The source address is rubbish. Also trying to get the 
destination address from IPV6_PKTINFO using CMSG_FIRSTHDR results in 
rubbish.

Can anyone explain why? Is there something different I have to do when 
using 802.15.4 and 6lowpan?

Regards
Simon
