Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35155 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbbE2JjW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 05:39:22 -0400
Received: by wicmx19 with SMTP id mx19so11860124wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 02:39:20 -0700 (PDT)
Date: Fri, 29 May 2015 11:39:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 0/4] Atusb driver improvements
Message-ID: <20150529093914.GE3709@omega>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 10:51:24AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> Some patches to let the atusb driver catchup a bit with newer stack features.
> Namely we now support tx power and promiscuous mode setting. The first patch
> adds some infrastructure for this by adding a function to write parts of a
> register.
> 
> The last patch adds me as the maintainer for the driver. Alex suggested that
> I should do this and as I have the device, working on the firmware as well
> and are motivated to enhance it I think its a good idea.
> 

Acked-by: Alexander Aring <alex.aring@gmail.com>

on the complete series.

- Alex
