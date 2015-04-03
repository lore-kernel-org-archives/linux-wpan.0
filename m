Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33365 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbbDCOpK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Apr 2015 10:45:10 -0400
Received: by wgin8 with SMTP id n8so23291428wgi.0
        for <linux-wpan@vger.kernel.org>; Fri, 03 Apr 2015 07:45:09 -0700 (PDT)
Date: Fri, 3 Apr 2015 16:45:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan on a RPi using at86rf233
Message-ID: <20150403144459.GA773@omega>
References: <20150403143647.GA6266@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150403143647.GA6266@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

On Fri, Apr 03, 2015 at 04:36:47PM +0200, Guido Günther wrote:
> Hi,
> I'm trying to get 6lowpan to work using bluetooth-next on the above
> hardware[1]. I'm currently using bluetooth-next as of
> baf880a96859cca79208122e555e7efeabd16e4d . When I do a:
> 
>    iwpan dev wpan0 set pan_id 0xbeef
> 
> I get:
> 
>    command failed: Device or resource busy (-16)
> 

you can set the pan_id when you interface is down only.

> or in detail:
> 
> #  src/iwpan --debug dev wpan0 set pan_id 0xbeef
> -- Debug: Sent Message:
> --------------------------   BEGIN NETLINK MESSAGE ---------------------------
>   [HEADER] 16 octets
>     .nlmsg_len = 36
>     .nlmsg_type = 21 <0x15>
>     .nlmsg_flags = 5 <REQUEST,ACK>
>     .nlmsg_seq = 1428071645
>     .nlmsg_pid = 2760
>   [PAYLOAD] 20 octets
>     0a 00 00 00 08 00 03 00 05 00 00 00 06 00 09 00 ef be ..................
>     00 00                                                 ..
> ---------------------------  END NETLINK MESSAGE   ---------------------------
> -- Debug: Received Message:
> --------------------------   BEGIN NETLINK MESSAGE ---------------------------
>   [HEADER] 16 octets
>     .nlmsg_len = 56
>     .nlmsg_type = 2 <ERROR>
>     .nlmsg_flags = 0 <>
>     .nlmsg_seq = 1428071645
>     .nlmsg_pid = 2760
>   [ERRORMSG] 20 octets
>     .error = -16 "Device or resource busy"
>   [ORIGINAL MESSAGE] 16 octets
>     .nlmsg_len = 16
>     .nlmsg_type = 21 <0x15>
>     .nlmsg_flags = 5 <REQUEST,ACK>
>     .nlmsg_seq = 1428071645
>     .nlmsg_pid = 2760
> ---------------------------  END NETLINK MESSAGE   ---------------------------
> 
> This looks similar to
> 
>    http://www.spinics.net/lists/linux-wpan/msg01290.html
> 
> but I'm running wpan-tools master already.
> 
> Before digging deeper it'd be great to know if these version should work together or if
> another kernel tree should be used otherwise I'll sprink some pr_debugs().
> Cheers,
>  -- Guido
> 
> [1] https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

- Alex
