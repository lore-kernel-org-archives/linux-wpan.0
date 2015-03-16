Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36065 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496AbbCPWRA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 16 Mar 2015 18:17:00 -0400
Received: by wibg7 with SMTP id g7so49124206wib.1
        for <linux-wpan@vger.kernel.org>; Mon, 16 Mar 2015 15:16:59 -0700 (PDT)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCHv2 0/2] cc2520: add support for CC2591
Date: Mon, 16 Mar 2015 18:16:41 -0400
Message-Id: <1426544203-60585-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Brad Campbell <bradjc5@gmail.com>

Hi,

I've updated the patch. I changed the `amplified` param to be a bool            
which was straightforward once I learned that device tree entries can           
have empty properties.                                                          
                                                                                
I added a second commit that should take of the issue of platform_data not      
being read-only in cc2520_hw_init. Let me know if I can improve it, although    
it is mostly copied from the at86rf230.c version. I didn't think it was         
necessary to pass each item in the cc2520_platform_data struct individually     
and instead just pass the struct to get_platform_data.                          
                                                                                
I have tested the patch with both a CC2520 and a CC2520+CC2591 combination.     
The patch boils down to just sending different register settings for the        
CC2520 and seems to work because I can send and receive with both radios.       
                                                                                
Thank you for looking over the patch and let me know if there is anything       
else I should fix.

Brad

changes since v1:
- change how platform_data is handled
- make amplified a bool instead of int

Brad Campbell (2):
  cc2520: Do not store platform_data in spi_device
  cc2520: Add support for CC2591 amplifier.

 .../devicetree/bindings/net/ieee802154/cc2520.txt  |   4 +
 drivers/net/ieee802154/cc2520.c                    | 148 +++++++++++++--------
 include/linux/spi/cc2520.h                         |   1 +
 3 files changed, 96 insertions(+), 57 deletions(-)

-- 
2.3.2

