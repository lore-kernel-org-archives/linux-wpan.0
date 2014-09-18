Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40571 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbaIRIpV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 04:45:21 -0400
Received: by mail-wi0-f172.google.com with SMTP id e4so2643424wiv.11
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 01:45:20 -0700 (PDT)
Date: Thu, 18 Sep 2014 10:45:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140918084515.GB3774@omega>
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de>
 <20140918083259.GA3774@omega>
 <541A99D4.8080509@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541A99D4.8080509@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 09:37:40AM +0100, Simon Vincent wrote:
> Sorry if I confused you, It is not a fakelb problem I get the same problem
> if I run using real 802.15.4 hardware (mrf24j40). The packet is put out by
> the driver but also sent to the RAW socket.
> 
Two mrf24j40 on the same host?

- Alex
