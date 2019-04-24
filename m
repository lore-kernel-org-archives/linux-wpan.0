Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:46161 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfDXSrc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Apr 2019 14:47:32 -0400
Received: from localhost.localdomain (p4FC2FAD0.dip0.t-ipconnect.de [79.194.250.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 3D84CCAA6B
        for <linux-wpan@vger.kernel.org>; Wed, 24 Apr 2019 20:47:30 +0200 (CEST)
Subject: Re: wpan-ping not working for an initial setup of Openlabs 802.15.4
 modules connected to rapsberry pi.
References: <6BFF517D-8A33-4817-A251-BE649C27BE3D@gmail.com>
 <114FA400-E2AA-441C-8691-B3D69E4C0414@gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <680c91cb-73df-c9e9-9d09-198bb2607d0f@datenfreihafen.org>
Date: Wed, 24 Apr 2019 20:47:29 +0200
MIME-Version: 1.0
In-Reply-To: <114FA400-E2AA-441C-8691-B3D69E4C0414@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 24.04.19 06:11, Aditya Nath wrote:
> Hi,
> 
> I’m trying to get basic ping working between the two devices and from each of them it says host unreachable.
> My setup includes 2 raspberry pi 3b+ model and each of them attached to 2 Openlabs 802.15.4 module.

This would be the first time they would communicate? Or did you had this
setup working before successfully?

What kernel version are you using on the rpi? Mainline or the Raspberry
provided kernel?

We had many problems that we helped debugging which ended in being a
problem with the rpi kernel and SPI or the wrong wiring (or wrongly
connected in the openlabs case). Thus I would like to ask you to double
and triple check on these. :-)

> I ran the following commands on each of them seperately:
> 
> ip link set wpan0 down
> iwpan phy0 set channel 0 15
> iwpan dev wpan0 set pan_id 0x1111
> iwpan dev wpan0 set short_addr 0x0001
> ip link set wpan0 up
> 
> wpan-ping -d 0x0002
> 
> The only difference between the two pi was that I changed the short_addr for the other pi to 0x0002.
> 
> The ping command used was:
> 
> wpan-ping -a 0x0001 -s 5 -c 5

Could you start wireshark/tshark/tcpdump on the server side wpan0
interface and see if packets are actually arriving? If not, try the same
on the client side wpan0 and check if you see them being submitted.

Even better if you have another device (from which you know that it
works) to use as a sniffer directly on the air.

> I understand you must tbe very busy, but I would really appreciate if you can support with some answers. There is very little thorough documentation on the web elsehwere, and that is why I have to turn to thtis mailing list for answes.

Another thing you could try is to setup 6lowpan fully and see if ping6
works. That would rule out problems with wpan-ping.

regards
Stefan Schmidt
