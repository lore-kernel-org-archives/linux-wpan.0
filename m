Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61717 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaI2LBV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 07:01:21 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so5642572pad.39
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 04:01:21 -0700 (PDT)
Message-ID: <54293B6C.7040800@gmail.com>
Date: Mon, 29 Sep 2014 16:28:52 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <54258332.2010004@xsilon.com> <20140926153521.GA7643@omega> <542593AC.4060901@xsilon.com> <20140927014243.GA26666@omega> <54293279.5090103@xsilon.com>
In-Reply-To: <54293279.5090103@xsilon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Simon,

On 09/29/2014 03:50 PM, Simon Vincent wrote:
> Currently there does not seem to be any filtering in the mac layer 
> anyway. In wpan.c mac802154_subif_frame we check the pan id and dest 
> address but we don't discard any packets. Should we be discarding 
> packets at this point? For example packets of type PACKET_OTHERHOST.
>
> If I discard all PACKET_OTHERHOST in mac802154_subif_frame it solves 
> my problem. I just don't know if this will effect anything else.
>
I think we are not supposed to discard the packets like this. This will
create the problems if routing enabled on the node.

This not problem with the IEEE-802.15.4 driver or MAC implementation.

These issues related to IPv6/ICMPv6 (ECHO request and ECHO reply). Here RFC2461/RFC4861 will
come into picture. see:http://www.tahi.org/logo/phase2-core/result/Self_Test_4-0-3/freebsd71.router/nd.p2/

Can you explain the setup..? What h/w you are using. How the network connected..?

-- 
Thanks and Regards,
Varka Bhadram.

