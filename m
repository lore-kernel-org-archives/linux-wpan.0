Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34583 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbbFIKEM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 06:04:12 -0400
Received: by payr10 with SMTP id r10so10700706pay.1
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jun 2015 03:04:12 -0700 (PDT)
Message-ID: <5576BA02.1050306@gmail.com>
Date: Tue, 09 Jun 2015 15:33:46 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bluetooth-next] ieee802154: cc2520: check for return
 values in cc2520_filter()
References: <1433843367-1976-1-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1433843367-1976-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

On 06/09/2015 03:19 PM, Stefan Schmidt wrote:

> neither ram nor register write return values have been checked here.
> Checking both now. Assign ret with 0 as all other assignments are inside
> if blocks and might not happen before we return ret.
>
> CID: 1230469
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Varka Bhadram

