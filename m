Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:47485 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbaIZIHy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 04:07:54 -0400
Received: by mail-wi0-f181.google.com with SMTP id z2so10984146wiv.2
        for <linux-wpan@vger.kernel.org>; Fri, 26 Sep 2014 01:07:53 -0700 (PDT)
Received: from omega (p20030064A93840FCE2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a938:40fc:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id q5sm5205624wja.49.2014.09.26.01.07.51
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2014 01:07:52 -0700 (PDT)
Date: Fri, 26 Sep 2014 10:07:45 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 0/3] mac: info: interface: add basic support
Message-ID: <20140926080742.GA10571@omega>
References: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

On Fri, Sep 26, 2014 at 10:06:06AM +0200, Alexander Aring wrote:
> Hi,
> 
> this patch series add support for setting lbt mode and dump phy parameters and
> mac interface parameters.
> 
> Each interface "could" have different mac parameters, because the mac sublayer
> means mac algorithmn which are done by phy. These parameters need to be the same
> on each interface. There are couple of mac sublayer parameters like ARET, CSMA,
> promiscuous mode, etc... These parameters will be changed if an interface will
> comming up, otherwise it's there but not running. Solution to run this device
> with different parameter is first down all others interfaces and then up the interface
> with the different parameters. (Difficult to explain maybe it's clear when you play a
> little bit with that).
> 
> PHY settings will directly set registers to the driver. There is no mac functionality.
> Only physical changes in radio frequency handling.
> 
> dump example for phy pib:
> 
> root@DistroKit:~ iwpan phy
> wpan_phy phy0
> supported channels:
>         page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26 
> current_page: 0
> current_channel: 26
> cca_mode: 1
> tx_power: 3
> 
> dump example for mac pib:
> 
> phy#0
>         Interface mon0
>                 ifindex 5
>                 wpan_dev 0x2
>                 extended_addr 0x0000000000000000
>                 short_addr 0xffff
>                 pan_id 0xffff
>                 type monitor
>                 max_frame_retries 3
>                 max_be 5
>                 max_csma_backoffs 4
>                 min_be 3
>                 lbt 0
>         Interface wpan0
>                 ifindex 2
>                 wpan_dev 0x1
>                 extended_addr 0xaaaaaaaaaaaaaaaa
>                 short_addr 0xffff
>                 pan_id 0xabcd
>                 type node
>                 max_frame_retries 3
>                 max_be 5
>                 max_csma_backoffs 4
>                 min_be 3
>                 lbt 0
> 

ah command for this was "iwpan dev", like iw tool for wireless.

- Alex
