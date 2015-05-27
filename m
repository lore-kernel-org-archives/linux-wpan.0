Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33116 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbE0KmA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 06:42:00 -0400
Received: by pdbqa5 with SMTP id qa5so9520585pdb.0
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 03:42:00 -0700 (PDT)
Message-ID: <55659F60.4050304@gmail.com>
Date: Wed, 27 May 2015 16:11:36 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-tools] wpan-tools: convert tx power value
References: <1432714898-23276-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1432714898-23276-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

On 05/27/2015 01:51 PM, Varka Bhadram wrote:

> This patch convert the tx power value from long to float to
> support the IEEE-802.15.4 radio power setting values.

I think here i need to fix (wpan-tools to phy) the commit message to which
this patch was targeting about.

I will do, and resend the patch.

-- 
Varka Bhadram

