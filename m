Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DF56BE.6000309@xsilon.com>
Date: Mon, 04 Aug 2014 10:47:42 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
References: <53DF4B10.7000209@xsilon.com> <20140804090403.GB15334@omega>
	<53DF4F7B.4090307@xsilon.com> <20140804093630.GD15334@omega>
	<20140804094147.GE15334@omega>
In-Reply-To: <20140804094147.GE15334@omega>
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

Oops, sorry about that.

- Martin

On 04/08/14 10:41, Alexander Aring wrote:
> Martin,
>
> On Mon, Aug 04, 2014 at 11:36:30AM +0200, Alexander Aring wrote:
>> On Mon, Aug 04, 2014 at 10:16:43AM +0100, Martin Townsend wrote:
>>> The changes were made to a clone of bluetooth-next, do I have the right repository?
>>>
>>> martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
>>> From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>>>
>> yes, but maybe it's a little bit outdated. Try to update it, on top of
>> git log should be the patches:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/log/
>>
> I think I know now why it fails. This patch depends on your previous patch
> ("6lowpan: Remove ununsed dev parameter from skb_delivery_cb
> callback."), otherwise I get merge conflicts.
>
> Normally you need to send this in a series of patches to avoid something
> like this. Now you need to wait until your patch ("6lowpan: Remove
> ununsed dev parameter from skb_delivery_cb callback.") go into the
> bluetooth-next tree.
>
>
> Next time, if you have a bunch of patches which depends on each other
> then send patch series. Sorry.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


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
