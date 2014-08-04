Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DF554F.9030604@xsilon.com>
Date: Mon, 04 Aug 2014 10:41:35 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
References: <53DF4B10.7000209@xsilon.com> <20140804090403.GB15334@omega>
	<53DF4F7B.4090307@xsilon.com> <20140804093630.GD15334@omega>
In-Reply-To: <20140804093630.GD15334@omega>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-zigbee-devel>
List-Post: <mailto:linux-zigbee-devel@lists.sourceforge.net>
List-Help: <mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-zigbee-devel-bounces@lists.sourceforge.net
Subject: Re: [Linux-zigbee-devel] [PATCH v3 bluetooth-next] Simplify lowpan
 receive path so skb is freed in, lowpan_rcv when dropped.
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net
List-ID: <linux-wpan.vger.kernel.org>

I did a pull first and after the merge my patch is still at the top of the log.

martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git pull
Already up-to-date.
martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git log
commit e3964f42db0e58e0ad289b89af0235af0db1f141
Author: Martin Townsend <martin.townsend@xsilon.com>
Date:   Fri Aug 1 15:59:57 2014 +0100

    Simplify lowpan receive path so skb is freed in lowpan_rcv when dropped.
   
    Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>

commit 751c8445fff787ad1fdb2a9285e8cf8ef865446d
Merge: 2ab17e7 dc6be9f
Author: Martin Townsend <martin.townsend@xsilon.com>
Date:   Fri Aug 1 15:15:06 2014 +0100

    Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next

commit 2ab17e768aa38426ec39a66a411b4f533dafa8c1
Author: Martin Townsend <martin.townsend@xsilon.com>
Date:   Fri Aug 1 10:08:05 2014 +0100

    Remove dev parameter from skb_delivery_cb in 6lowpan.
   
    This parameter is never used by any function implementing this callback.
   
    Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>

...

I'll check the patch hasn't been mangled by my email client somehow.

- Martin

On 04/08/14 10:36, Alexander Aring wrote:
> On Mon, Aug 04, 2014 at 10:16:43AM +0100, Martin Townsend wrote:
>> The changes were made to a clone of bluetooth-next, do I have the right repository?
>>
>> martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
>> From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>>
> yes, but maybe it's a little bit outdated. Try to update it, on top of
> git log should be the patches:
>
> http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/log/
>
> - Alex


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel
