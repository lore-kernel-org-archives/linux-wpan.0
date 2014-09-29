Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61407 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbaI2KUo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 06:20:44 -0400
Message-ID: <54293279.5090103@xsilon.com>
Date: Mon, 29 Sep 2014 11:20:41 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <54258332.2010004@xsilon.com> <20140926153521.GA7643@omega> <542593AC.4060901@xsilon.com> <20140927014243.GA26666@omega>
In-Reply-To: <20140927014243.GA26666@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Currently there does not seem to be any filtering in the mac layer 
anyway. In wpan.c mac802154_subif_frame we check the pan id and dest 
address but we don't discard any packets. Should we be discarding 
packets at this point? For example packets of type PACKET_OTHERHOST.

If I discard all PACKET_OTHERHOST in mac802154_subif_frame it solves my 
problem. I just don't know if this will effect anything else.


On 27/09/14 02:42, Alexander Aring wrote:
> all p

